--[[ FX Information ]]
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]]
name 'futte-newspaper'
version '1.0'
author 'xFutte'
description 'News script'

ui_page 'web/public/index.html'

server_scripts {
    "server/**/*"
}

shared_scripts { 
    'shared/frameworkObject.lua',
    'shared/init.lua',
    'shared/const.lua',
    'config.lua', 
}

client_scripts {
    'client/**/*', 
    '@PolyZone/client.lua', 
    '@PolyZone/EntityZone.lua'
}

files {
    'web/public/index.html', 
    'web/public/**/*'
}