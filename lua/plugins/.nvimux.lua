local nvimux = require('nvimux')

nvimux.setup {
    config = {
        prefix = '<C-a>',
    },
    bindings = {
        {{'n', 'v', 't'}, 's', nvimux.commands.horizontal_split},
        {{'n', 'v', 't'}, 'v', nvimux.commands.vertical_split},
    }
}
