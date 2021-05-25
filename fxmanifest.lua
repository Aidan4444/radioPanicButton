fx_version "cerulean"
game "gta5"

author "Aidan_ogg#0001"
description "Requires [mumble-voip && rp-radio]"

client_scripts {
    'config.lua',
    'functions.lua',
    'client.lua'
}

server_scripts {
    'server.lua',
    'config.lua'
}

ui_page 'html/ui.html'

files {
    'html/*',
    'html/sounds/*.ogg'
}