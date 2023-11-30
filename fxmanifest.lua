--[[ FX Information ]]
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]]
name 'futte-newspaper'
version '1.0'
author 'xFutte'
contributors {
    'NewEdit'
}

description 'News script'

ui_page 'web/public/index.html'

server_scripts {
    'server/framework/*.lua',
    'server/sv-db.lua',
    'server/sv-main.lua',
    'server/sv-init.lua',
}

shared_scripts { 
    'shared/frameworkObject.lua',
    'shared/init.lua',
    'shared/const.lua',
    'config.lua', 
}

client_scripts {
    'client/framework/*.lua',
    'client/cl-nui.lua',
    'client/cl-func.lua',
    'client/cl-main.lua',
}

files {
    'web/public/index.html', 
    'web/public/**/*'
}