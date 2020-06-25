fx_version "adamant"

game "gta5"

author 'Deniz#4119'

client_scripts {
    '@es_extended/locale.lua',
    'weed.lua',
    'tr.lua',
    'client.lua',
    'config.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'weedserver.lua',
	'tr.lua',
    'server.lua',
    'config.lua',
}

dependencies {
	'es_extended'
}