# @deepwhale-cn/dsh-incident-package

**应急证据包** —— 查出了事能不能拿出证据：预案、联系人、日志保全、上报流程。

## 不装它会怎样

你的项目有日志：

```js
const logger = require('winston');
logger.info('app started');
```

**看起来该有的都有了。但出事那天你会发现：**

```
① 预案呢？          —— 《网络安全法》第 25 条：应当制定
② 打给谁？          —— 凌晨三点没人知道该找谁
③ 日志能证明什么？   —— 日志和业务库同机同账号，攻击者进来一把删掉
④ 要报给主管部门吗？ —— 数据安全法第 29 条：还要及时告知用户
```

**平时不备，事到临头就晚了。** 而这些都是**可以提前自查**的。

## 关键词
**关键词**：应急预案 · 应急响应 · 应急联系人 · 证据保全 · 事件上报 · 日志留存 · 网络安全法 · 数据安全法
**Keywords**: incident response · emergency plan · evidence preservation · incident reporting · CSL · DSL

## 它查什么

| 级别 | 内容 | 依据 |
|---|---|---|
| 🔴 高 | 找不到**应急预案** | 网安法 25 条 |
| 🔴 高 | 有日志但找不到**证据保全**（异地/不可篡改/快照）| 网安法 21 条 · 等保 安全审计 |
| 🟡 中 | 找不到**应急联系人** | 等保 安全管理体系 |
| 🟡 中 | 找不到**事件上报流程** | 网安法 25 条 · 数据安全法 29 条 |

## 「日志被一把删掉」是这个插件重点要拦的

很多团队有日志，但**日志和业务库在同一台机器、同一个账号下**。

攻击者进来第一件事就是删日志 —— 事后什么都查不到。

等保要求「审计记录应受到保护，**避免受到未预期的删除、修改或覆盖**」。

## 安装

```bash
dsh plugin --profile web add @deepwhale-cn/dsh-incident-package
# 或纯 CLI
npx @deepwhale-cn/dsh-incident-package
```

![dsh-incident-package 检查报告示例](https://www.deepwhale.org.cn/plugin-assets/dsh-incident-package/report.png)

![dsh-incident-package 演示模式输出](https://www.deepwhale.org.cn/plugin-assets/dsh-incident-package/demo.png)

![dsh-incident-package 规则与依据](https://www.deepwhale.org.cn/plugin-assets/dsh-incident-package/rules.png)

## 用法

```bash
dsh-incident-package --demo
dsh-incident-package --list-rules
dsh-incident-package --html r.html
```

## 边界

- **不检查预案质量** —— 只查「有没有」。预案写得好不好、演练过没有，需要人工评审。
- **不验证联系人真的能打通** —— 只查文档里有没有。
- **预案可能在其他仓库/内部系统** —— 报出来是提示你确认，不是断定你没做。
- **证据保全只看配置与文档** —— 实际存储权限、WORM 策略是否生效，需要人工验证。
- 与 [dsh-alert-relay](https://github.com/feely0208/dsh-alert-relay) 分工：
  那个查**出事时通知谁**，这个查**出事前准备了什么**。
- 与 [dsh-cn-log-retention](https://github.com/feely0208/dsh-cn-log-retention) 分工：
  那个查日志**留多久**，这个查日志**能不能被信任**。

本插件是一个工具。使用者必须遵守所在地区法律法规，**对使用本项目造成的任何后果自行承担责任。**


---

## 深鲸网安守护系列（共 22 个）

> 一个插件做一件事。**安全问题是链式的** —— 配套用才完整。

**国内合规** ｜ [等保对照](https://github.com/feely0208/dsh-cn-mlps) · [日志留存](https://github.com/feely0208/dsh-cn-log-retention) · [备案公示](https://github.com/feely0208/dsh-cn-filing) · [用户同意](https://github.com/feely0208/dsh-consent-guard) · [个人信息权利](https://github.com/feely0208/dsh-data-rights) · [未成年人保护](https://github.com/feely0208/dsh-minor-guard) · [影响评估](https://github.com/feely0208/dsh-pipia) · [数据分类分级](https://github.com/feely0208/dsh-data-classify) · [算法备案](https://github.com/feely0208/dsh-algorithm-filing) · [数据出境](https://github.com/feely0208/dsh-cn-data-export)

**AI 与 Agent 治理** ｜ [AI 输出信任](https://github.com/feely0208/dsh-ai-output-trust) · [外部内容信任](https://github.com/feely0208/dsh-content-trust) · [MCP 安全](https://github.com/feely0208/dsh-mcp-audit) · [Agent 权限](https://github.com/feely0208/dsh-agent-scope)

**数据与凭据** ｜ [敏感数据](https://github.com/feely0208/dsh-data-scan) · [密钥轮换](https://github.com/feely0208/dsh-key-rotate)

**供应链与构建** ｜ [开源许可](https://github.com/feely0208/dsh-license-guard) · [依赖投毒](https://github.com/feely0208/dsh-dep-audit) · [CI 安全](https://github.com/feely0208/dsh-ci-guard)

**权限与应急** ｜ [最小权限](https://github.com/feely0208/dsh-least-privilege) · [告警外发](https://github.com/feely0208/dsh-alert-relay) · [**应急证据包**](https://github.com/feely0208/dsh-incident-package)

都在 DSH 插件市场（dsh-plugin.org）和 npm 上，`dsh plugin --profile web add <包名>` 即可安装。

## License

MIT © 深鲸 DeepWhale
