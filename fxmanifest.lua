fx_version 'cerulean'
game 'gta5'

lua54 'yes'

ui_page 'web/public/index.html'

author 'xFutte'
description 'News script'
version '1.0'

shared_script 'config.lua'

client_script {'client/**/*', '@PolyZone/client.lua', '@PolyZone/EntityZone.lua'}
server_script "server/**/*"

files {'web/public/index.html', 'web/public/**/*'}

server_exports {'CreateJailStory'}
