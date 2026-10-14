import { createPlugin, pkgRootFrom } from '@deepwhale-cn/dsh-guard-core/plugin';

export const { name, inject, apply } = createPlugin({
  name: 'incident-package',
  pkgRoot: pkgRootFrom(import.meta.url),
  skillFile: 'skill/incident-package.md',
  binFile: 'bin/cli.mjs',
  description: '查出了事能不能拿出证据：预案、联系人、日志保全、上报流程 —— 平时不备，事到临头就晚了',
  whenToUse: 'TODO：写清什么时候该用（用户会说的话也列上）',
});
