# ADR-002: 保留 ressession colorscheme 持久化

## 状态
已接受（2026-06-19）

## 背景
ressession 插件的 `colorscheme` 扩展会在 session 保存时记录当前主题，在 session 加载时恢复。

工作流变化：
- 旧流程：单实例 neovide，通过 tab 切换项目
- 新流程：固定主实例 + pop-launcher 快速打开项目（每个项目独立实例）

## 方案对比

### 方案 A：禁用 ressession colorscheme + 启用时间自动切换
- **实现**：禁用 `colorscheme = {}`，添加定时器每小时检查时间并切换主题
- **优点**：所有实例统一主题，按时间自动调整
- **缺点**：失去项目独立主题能力，需要维护定时器代码，每小时触发一次有性能开销

### 方案 B：保留 ressession colorscheme（当前）
- **实现**：保持 `colorscheme = {}` 启用，不添加自动切换
- **优点**：每个项目有独立主题（方便区分），设置一次永久有效，零维护成本
- **缺点**：无法按时间自动切换

## 决策
保留方案 B：启用 ressession colorscheme 扩展。

## 理由
1. **符合工作流**：pop-launcher 打开的是新实例，每个实例有独立 session，主题独立
2. **功能价值**：多项目并行时，通过主题颜色区分上下文
3. **成本效益**：零设置成本，零维护成本，性能开销可忽略
4. **实际场景**：主要在固定时段工作，时间切换意义不大；手动切换主题后，下次打开同项目自动恢复

## 后果
- 每个项目的 session 文件保存各自的 colorscheme
- 新打开的项目使用默认主题（gruvbox-material light）
- 手动切换主题后，下次打开同项目会恢复
- 主实例（terminal 启动）也有独立的 session 和主题
