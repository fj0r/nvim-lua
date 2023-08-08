local set_title = function(title)
    vim.o.title = true
    vim.o.titlestring = title
end

local prompt_set_title = function()
    if vim.g.ui_prompt then
        vim.ui.input({ prompt = 'rename title', default = vim.o.titlestring }, function(input)
            set_title(input)
        end)
    else
        local input = vim.fn.input('rename title: ', vim.o.titlestring)
        set_title(input)
    end
end

local set_tab_title = function(pin, cb)
    pin = pin or '^'
    local action = cb(pin)
    local prompt = function()
        local c = vim.v.count
        local p
        if c == 0 then
            local currname = vim.t[vim.api.nvim_get_current_tabpage()].tabname
            if currname and string.sub(currname, 1, 1) == pin then
                p = string.sub(currname, 2, #currname)
            else
                p = ''
            end
        else
            local parents = {}
            local cwd = vim.fn.getcwd()
            if cwd == nil then return end
            for pr in vim.fs.parents(cwd) do
                table.insert(parents, pr)
            end
            p = vim.fn.substitute(cwd, parents[c] .. '/', '', nil)
        end
        --local p = vim.fn.substitute(vim.fn.getcwd(), vim.fn.getenv('HOME'), '~', '')
        --local p = vim.fs.basename(vim.fn.getcwd())
        if vim.g.ui_prompt then
            vim.ui.input({ prompt = 'rename tab', default = p }, function(input)
                if not input then return end
                action(input)
            end)
        else
            local input = vim.fn.input('rename tab: ', p)
            action(input)
        end
    end

    return { set = action, prompt = prompt }
end

local set_lualine = function(pin)
    return function(name)
        vim.t[vim.api.nvim_get_current_tabpage()].tabname = name == '' and '' or pin .. name
    end
end

local tab_title = set_tab_title('^', set_lualine)

require('setup').keymap_table {
    { '<M-r>', prompt_set_title, mode = 'nit', desc = 'set title' },
    { '<M-t>', tab_title.prompt, mode = 'nit', desc = 'set tab title' },
}

vim.api.nvim_create_user_command('TabTitle', function(ctx) tab_title.set(ctx.args) end, { nargs = '?' })
vim.api.nvim_create_user_command('Title', function(ctx) set_title(ctx.args) end, { nargs = '?' })

set_title '🏝️'
