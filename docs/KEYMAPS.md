# Neovim Keymaps Reference

本文档列出所有自定义 keymaps 及其来源插件。

**Mode 说明**：
- `n` = Normal
- `v` = Visual
- `x` = Visual (不含 Select)
- `o` = Operator-pending
- `i` = Insert
- `t` = Terminal
- `c` = Command-line

---

## 核心配置 (common/)

### common/keymap.lua
| Mode | Key | Description |
|------|-----|-------------|
| all | `<Space>` | Leader key (Nop) |
| all | `U` | Redo (`<C-r>`, like Helix) |
| n,v | `<leader>y` | Yank to clipboard (`"+y`) |
| n,v | `<leader>Y` | Yank line to clipboard (`"+Y`) |
| n,v | `<leader>p` | Paste from clipboard (`"+p`) |
| n,v | `<leader>P` | Paste from clipboard before (`"+P`) |

### common/window.lua
| Mode | Key | Description |
|------|-----|-------------|
| all | `<leader>wh` | Window resize horizontal (带数字参数，如 `3wh`) |
| all | `<leader>wv` | Window resize vertical (带数字参数，如 `3wv`) |

---

## 插件 Keymaps (manifest/)

### Telescope (component.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>\` | telescope pickers |
| n | `<leader>D` | telescope lsp_document_symbols |
| n | `<leader>a` | telescope marks |
| n | `<leader>z` | telescope registers |
| n | `<leader>d` | telescope oldfiles |
| n | `<leader>f` | telescope find_files |
| n | `<leader>r` | telescope live_grep |
| n | `<leader>T` | telescope tabs |
| n | `<leader>F` | telescope git_files |
| n | `<leader>gc` | telescope git_commits |

### Neo-tree (component.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>e` | Neotree reveal |

### Window Picker (component.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>ww` | window picker |
| n,x,i,t | `<M-q>` | window picker |

### WinShift (component.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>ws` | winshift swap |
| n | `<leader>wx` | winswap |

### Mundo (component.lua) - **DISABLED**
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>u` | mundo toggle |

### Which-key (base.lua) - **ENABLED**
Which-key 已启用，会在输入快捷键时显示可用选项的提示弹窗。

### LSP (dev.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `gd` | declaration |
| n | `;x` | references |
| n | `;d` | definition |
| n | `K` | hover |
| n | `gi` | implementation |
| n | `;k` | signature_help |
| n | `;wa` | add_workspace_folder |
| n | `;wr` | remove_workspace_folder |
| n | `;wl` | list_workspace_folders |
| n | `;D` | type_definition |

### DAP (dev.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `,b` | toggle_breakpoint |
| n | `,l` | list_breakpoints |
| n | `,B` | condition_breakpoint |
| n | `,L` | log_breakpoint |
| n | `,c` | continue |
| n | `,s` | step_over |
| n | `,g` | goto_ |
| n | `,i` | step_into |
| n | `,o` | step_out |
| n | `,r` | run_to_cursor |

### Aerial (dev.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<C-s>` | AerialTelescope |
| n | `<leader>s` | AerialToggle |

### Trouble (dev.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>gw` | Diagnostics (Trouble) |
| n | `<leader>gs` | Symbols (Trouble) |
| n | `<leader>gl` | Location List (Trouble) |
| n | `<leader>gq` | Quickfix List (Trouble) |
| n | `<leader>gr` | LSP Definitions / references / ... (Trouble) |

### Todo Comments (dev.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>ga` | TodoTelescope |
| n | `<leader>gt` | TodoTrouble |

### Spectre (enhancement.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>/` | Toggle Spectre |

### EasyAlign (enhancement.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,x | `ga` | EasyAlign |

### Comment.nvim (enhancement.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,x | `<leader>c` | toggle comment |

### Whitespace (enhancement.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `gw` | remove tailing whitespace |

### Orgmode (lang.lua) - **DISABLED**
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>oa` | orgmode agenda |
| n | `<leader>oc` | orgmode capture |

### Flash (motion.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,x,o | `s` | search |
| n,o | `S` | treesitter |
| o | `r` | remote |
| o,x | `R` | treesitter_search |
| c | `<c-s>` | toggle |

### Hop (motion.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,x,o | `<leader><leader>` | hop hint_words |
| n,x,o | `<leader>;` | hop hint_lines |

### Overseer (task.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,t | `<leader>t` | OverseerToggle |
| n | `<leader>or` | OverseerRun |
| n | `<leader>oo` | OverseerToggle |
| n | `<leader>ob` | OverseerBuild |
| n | `<leader>ot` | OverseerTaskAction |
| n | `<leader>oq` | OverseerQuickAction |

### Taberm (term.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<M-\>` | tab |

**内部 keymaps** (opts.keymap):
- `<M-[>` = toggle
- `<M-]>` = toggle_h
- `<M-y>` = paste

### ToggleTerm (term.lua) - **DISABLED**
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>xt` | toggleterm |
| n | `<leader>xy` | vtoggleterm |
| n | `<leader>xp` | toggleterm ipython |

### Diffview (vcs.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>gd` | DiffviewOpen |
| n | `<leader>gf` | DiffviewFileHistory % |
| n | `<leader>gh` | DiffviewHistory |
| n | `<leader>gx` | DiffviewClose |

### Neogit (vcs.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>gg` | neogit |

---

## 其他 Keymaps (other/ & settings/)

### Translate (other/translate.lua)
| Mode | Key | Description |
|------|-----|-------------|
| x | `<leader>e` | english to chinese |
| x | `<leader>z` | chinese to english |

### Terminal (manifest/term.lua)
| Mode | Key | Description |
|------|-----|-------------|
| t | `<MouseMove>` | NOP (disable mouse move in terminal) |

### Cmdbuf (settings/.cmdbuf.lua) - **DISABLED**
| Mode | Key | Description |
|------|-----|-------------|
| n | `q:` | cmdbuf |
| c | `<C-f>` | cmdbuf |
| n | `q` | quit (buffer-local) |
| n | `dd` | delete (buffer-local) |
| n | `ql` | command history |
| n | `q/` | search history |
| n | `q?` | search history |

### Toggletasks (settings/.toggletasks.lua) - **DISABLED**
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>j` | toggletasks: spawn |
| n | `<leader>k` | toggletasks: select |

### Aerial (settings/aerial.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `{` | AerialPrev (buffer-local) |
| n | `}` | AerialNext (buffer-local) |

### Gitsigns (settings/gitsigns.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n,x,o | `l` | gitsigns attach |

### LSP (settings/lsp/common.lua)
| Mode | Key | Description |
|------|-----|-------------|
| v | `[f` | LSP keymap |

### LuaSnip (settings/luasnip.lua)
| Mode | Key | Description |
|------|-----|-------------|
| v | `<M-s>` | LuaSnip keymap |
| i | `i` | LuaSnip keymap |

### Neophyte (settings/neophyte.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<c-+>` | increase font size |
| n | `<c-_>` | decrease font size |

### Resession (settings/ressession.lua)
| Mode | Key | Description |
|------|-----|-------------|
| n | `<leader>SS` | save session |
| n | `<leader>SL` | load session |
| n | `<leader>SD` | delete session |

**Commands**:
- `:SS [name]` - Save session
- `:SL [name]` - Load session
- `:SD [name]` - Delete session

---

## 禁用插件 (文件名以 `.` 开头)

以下插件配置文件以 `.` 开头，表示已禁用：
- `.asyncrun.lua`
- `.auto-session.lua`
- `.clap.lua`
- `.cmdbuf.lua`
- `.dial.lua`
- `.format.lua`
- `.lush.lua`
- `.nvim-rss.lua`
- `.nvimux.lua`
- `.osc52.lua`
- `.period-themes.lua`
- `.persisted.lua`
- `.sneak.lua`
- `.theme.lua`
- `.tmux.lua`
- `.toggletasks.lua`
- `.toggleterm.lua`
- `.vista.lua`
- `.yabs.lua`

---

## 快速参考

### 文件操作
- `<leader>f` - Find files (Telescope)
- `<leader>r` - Live grep (Telescope)
- `<leader>d` - Old files (Telescope)
- `<leader>e` - Neo-tree reveal

### 剪贴板
- `<leader>y` - Yank to clipboard
- `<leader>Y` - Yank line to clipboard
- `<leader>p` - Paste from clipboard
- `<leader>P` - Paste from clipboard before

### 编辑操作
- `U` - Redo (like Helix)
- `<leader>wh` - Window resize horizontal
- `<leader>wv` - Window resize vertical
- `<leader>ww` - Window picker
- `<M-q>` - Window picker (all modes)
- `<leader>ws` - WinShift swap
- `<leader>wx` - WinShift

### 代码导航 (LSP)
- `gd` - Go to declaration
- `;d` - Go to definition
- `;x` - References
- `gi` - Implementation
- `;D` - Type definition
- `K` - Hover
- `<leader>D` - LSP document symbols (Telescope)

### 调试 (DAP)
- `,b` - Toggle breakpoint
- `,c` - Continue
- `,s` - Step over
- `,i` - Step into
- `,o` - Step out

### 版本控制
- `<leader>gg` - Neogit
- `<leader>gd` - Diffview open
- `<leader>gf` - File history
- `<leader>gh` - History

### 搜索替换
- `<leader>/` - Spectre (search and replace)
- `ga` - EasyAlign
- `<leader>c` - Toggle comment (Comment.nvim)

### 任务运行
- `<leader>t` - Overseer toggle
- `<leader>or` - Overseer run

### 运动增强
- `s` - Flash search
- `S` - Flash treesitter
- `<leader><leader>` - Hop words
- `<leader>;` - Hop lines

### 翻译
- `<leader>e` (visual) - English to Chinese
- `<leader>z` (visual) - Chinese to English

### Session 管理
- `<leader>SS` - Save session
- `<leader>SL` - Load session
- `<leader>SD` - Delete session
- `:SS [name]` - Save session (command)
- `:SL [name]` - Load session (command)
- `:SD [name]` - Delete session (command)
