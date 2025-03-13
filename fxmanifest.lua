fx_version 'cerulean'

game 'gta5'

author 'Lusty94'

name "lusty94_shops"

description 'Shop Script For For QB Core'

version '1.0.0'

lua54 'yes'

client_script {
    'client/cl_funcs.lua',
}


server_scripts { 
    'server/sv_funcs.lua',
    '@oxmysql/lib/MySQL.lua',
}


shared_scripts { 
    'shared/config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'shared/**.lua',
    'client/**.lua',
    'server/**.lua',
}


