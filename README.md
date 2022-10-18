 # orgmode
 # migrate from tmux
 - [x] C-w x/C-w C-x (swap window)
 - [x] M-hjkl (resize)
 - [x] M-# (switch tab)

 - [x] stdout > output to buffer
 - [x] bind `<C-r>` to terminal mode
    - [x] lua
    - [x] shell: C-s for `history_menu`
    - [ ] use registers
 - [x] `new_term`
    - [x] specify shell
    - [x] open term with cmd :X echo hello word
    - [-] description
    - [x] close window when term exit
    - [-] possession adapt
 - [x] rename tab (lualine)
    - [x] beautify path
    - [x] keybindings (M-r)
 - [x] nushell
    - [x] send '\n'
    - [x] auto tcd
       - [-] do not `tcd` when multiple term in one tab
       - [x] pin tabname manually
       - [x] smart tcd (HookPwdChanged: is git or not under git)
    - [x] open file in cli
       - [x] open file not in cwd
    - [x] opposite pwd
 - [x] disable redundant plugins
    - [x] osc52
    - [x] registres.nvim
    - [x] yabs -> overseer
    - [x] nvim-goggleterm.lua
 - [x] default [No Name] buffer -> terminal (possession.lua)
 - [ ] clean quited buffer
 - [x] $env.EDITOR
    - [ ] `git_COMMIT` (remote-wait)

# extension
 - [ ] packer lazy load by key, desc for which-key
    https://github.com/wbthomason/packer.nvim/issues/925
 - [ ] feed
 - [ ] email
 - [x] neovide
 - [ ] hop target include `[]{}<>'",;#`
