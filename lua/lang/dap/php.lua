local dap = require'dap'

--[[
zend_extension=xdebug.so
xdebug.mode=debug
xdebug.remote_handler=dbgp
xdebug.discover_client_host=true
xdebug.remote_port=9000
--]]
-- curl 'http://localhost/?XDEBUG_SESSION_START=xdebug'
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/opt/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9000
    }
}

