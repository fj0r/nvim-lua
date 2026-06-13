# ADR-001: 文件位置复制使用绝对路径 + ~ 缩写

## 状态
Accepted

## 背景
`<leader>l` 快捷键用于复制文件位置到剪贴板，配合 AI 工具定位代码。需要决定默认输出绝对路径还是相对路径。

## 决策
**默认使用绝对路径，并将 `$HOME` 替换为 `~`**。

示例：`~/Configuration/nvim/lua/common/keymap.lua:22`

## 理由

### 为什么不是相对路径？
- **项目级 AI（Cursor/Copilot）**：天然绑定 workspace，相对路径足够，且很多直接集成在编辑器中，不需要手动复制
- **全局性 AI（Hermes）**：跨项目运行，收到 `lua/common/keymap.lua:22` 时不知道属于哪个项目，除非显式传入 cwd 上下文

### 为什么用 ~ 缩写？
1. **更短**：`~/Configuration/nvim/...` vs `/home/master/Configuration/nvim/...`
2. **更直观**：一眼看出是用户目录下的文件
3. **更通用**：`~` 是 Unix 通用约定，AI 工具和 shell 都能正确解析
4. **隐私**：避免泄露不必要的用户名信息（如 `/home/john.doe/...`）

## 位掩码设计
通过 `vim.v.count` 前置数字控制输出格式：

| count | bit0 (相对) | bit1 (列号) | 输出格式 |
|-------|-------------|-------------|----------|
| 0     | 0           | 0           | `~/path:line` (默认) |
| 1     | 1           | 0           | `path:line` (相对) |
| 2     | 0           | 1           | `~/path:line:col` |
| 3     | 1           | 1           | `path:line:col` (相对+列号) |

Visual 模式自动使用行范围格式：`path:start-end` 或 `path:start-end:col_start-col_end`

## 实现
- 绝对路径：`vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~')`
- 相对路径：`vim.fn.expand('%')`
- 剪贴板：`vim.fn.setreg('+', result)`
