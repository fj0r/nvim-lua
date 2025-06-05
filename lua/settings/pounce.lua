require 'pounce'.setup {
    accept_keys = "jfkdlsahgnuvrbytmiceoxwpqz",
    accept_best_key = "<enter>",
    multi_window = true,
    debug = false,
}

local km = {
    somewhere = function() require 'pounce'.pounce {} end,
    repeats = function() require 'pounce'.pounce { do_repeat = true } end,
    search = function() require 'pounce'.pounce { input = { reg = "/" } } end,
}

return {
    setup = function(plugin, ctx)
        ctx.apply_keymap(plugin.keys, km)
    end
}
