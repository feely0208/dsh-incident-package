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

## 「日志被一把删掉」是这个插件最想拦的

很多团队有日志，但**日志和业务库在同一台机器、同一个账号下**。

攻击者进来第一件事就是删日志 —— 事后什么都查不到。

等保要求「审计记录应受到保护，**避免受到未预期的删除、修改或覆盖**」。

## 安装

```bash
dsh plugin --profile web add @deepwhale-cn/dsh-incident-package
# 或纯 CLI
npx @deepwhale-cn/dsh-incident-package
```

![dsh-incident-package 的检查报告示例](https://www.deepwhale.org.cn/plugin-assets/dsh-incident-package/report.png)

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

## License

MIT © 深鲸 DeepWhale
