local selection = function()
	if vim.fn.mode() == "v" then
		local start_pos = vim.fn.getpos("v")
		local finish_pos = vim.fn.getpos(".")
		local start_line, start_col = start_pos[2], start_pos[3]
		local finish_line, finish_col = finish_pos[2], finish_pos[3]

		if start_line > finish_line or (start_line == finish_line and start_col > finish_col) then
			start_line, start_col, finish_line, finish_col = finish_line, finish_col, start_line, start_col
		end

		local lines = vim.fn.getline(start_line, finish_line)
		if #lines == 0 then
			return ""
		end
		lines[#lines] = string.sub(lines[#lines], 1, finish_col)
		lines[1] = string.sub(lines[1], start_col)
		return table.concat(lines, "\n")
	else
		return vim.fn.expand("<cexpr>")
	end
end

local libretranslate = function (ctx)
    local curl = require('plenary').curl
    local host = ctx.host or 'http://localhost:5000'
    local r = curl.post(host .. '/translate', {
        body = {
            q = ctx.q,
            source = ctx.en and 'en' or 'zh',
            target = ctx.en and 'zh' or 'en',
            format = "text"
        },
        header = {["Content-Type"] = "application/json"}
    })
    return vim.json.decode(r.body).translatedText
end


local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
local translate = function(ctx)
    return function()
        local host = os.getenv('LIBRETRANSLATE_HOST')
        if host ~= nil then
            local a = libretranslate {
                q = selection(),
                en = ctx.en,
                host = host
            }
            vim.fn.setreg('+', a)
            require('notify')(a, 'info', { title = 'translate', render = 'simple' })
        end
        vim.api.nvim_feedkeys(esc, 'x', false)
    end
end


vim.keymap.set('v', '<leader>e', translate {en = true}, { noremap = true, silent = true, desc = 'english to chinese'})
vim.keymap.set('v', '<leader>z', translate {}, { noremap = true, silent = true, desc = 'chinese to english'})
