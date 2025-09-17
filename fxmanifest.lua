fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Panda'
description 'A FiveM resource for managing player identities'
version '1.0.0'

shared_script '@ox_lib/init.lua'

client_script 'client.lua'

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua'
}

files {
    'web/build/**'
}
ui_page 'web/build/index.html'