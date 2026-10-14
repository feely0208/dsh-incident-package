#!/bin/bash
set -uo pipefail
cd "$(dirname "$0")/.."
PASS=0; FAIL=0
ok(){ echo "  ✅ $1"; PASS=$((PASS+1)); }
bad(){ echo "  ❌ $1"; FAIL=$((FAIL+1)); }
echo ""; echo "  @deepwhale-cn/dsh-incident-package · 双向验证"
echo "  ────────────────────────────────────────────────"
J=$(node bin/cli.mjs --root tests/fixtures/fail/demo-project --json 2>&1)
for rid in INCIDENT-NO-PLAN INCIDENT-NO-CONTACT INCIDENT-NO-REPORT; do
  c=$(echo "$J" | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='$rid']))" 2>/dev/null)
  [ "${c:-0}" -gt 0 ] && ok "$rid 报出（正例）" || bad "$rid 未报出"
done
A=$(node bin/cli.mjs --root tests/fixtures/absent/minimal --json 2>&1)
c=$(echo "$A" | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='INCIDENT-NO-PRESERVE']))" 2>/dev/null)
[ "${c:-0}" -gt 0 ] && ok "INCIDENT-NO-PRESERVE 在空缺样本上报出（有日志但无保全）" || bad "INCIDENT-NO-PRESERVE 未报出"
M=$(node bin/cli.mjs --root tests/fixtures/pass/clean-project --quiet 2>&1 | grep -oE '^[0-9]+' | head -1)
[ "${M:-1}" = "0" ] && ok "合规样本 0 命中（预案+联系人+保全+上报齐全）" || bad "误报 ${M} 条"
echo ""; echo "  【条件规则】无日志的项目，保全规则判为不适用"
NA=$(node bin/cli.mjs --root /tmp/empty-proj --json 2>&1 | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(','.join((d.get('stats') or {}).get('notApplicable') or []))" 2>/dev/null || echo "")
mkdir -p /tmp/empty-proj && echo '{"name":"e","version":"1.0.0"}' > /tmp/empty-proj/package.json
NA=$(node bin/cli.mjs --root /tmp/empty-proj --json 2>&1 | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(','.join((d.get('stats') or {}).get('notApplicable') or []))" 2>/dev/null)
echo "$NA" | grep -q "INCIDENT-NO-PRESERVE" && ok "无日志项目：保全规则不适用" || bad "条件规则未生效（$NA）"
echo ""; echo "  【语义一致性 + 法条】"
python3 - <<'PY' && ok "4 条规则语义一致且引法条" || bad "有规则不合格"
import json,glob,sys
for f in glob.glob('rules/*.json'):
    r=json.load(open(f,encoding='utf-8')); t=r.get('title','')
    if any(w in t for w in ('找不到','未发现','缺少')) and r['check']['type']!='files-lack':
        print('语义相反:',r.get('id'),file=sys.stderr); sys.exit(1)
    if '第' not in (r.get('source') or ''): print('未引法条:',r.get('id'),file=sys.stderr); sys.exit(1)
PY
echo ""; echo "  ────────────────────────────────────────────────"
echo "  通过 $PASS · 失败 $FAIL"; echo ""
[ "$FAIL" -eq 0 ] || exit 1
