fx_version 'adamant'
game 'gta5'
version '1.0.0'

Author 'AlphaEnFolie'

client_scripts {
    'src/vendors/RageUI/RageConfig.lua',
    'src/vendors/RageUI/RageUI.lua',
    'src/vendors/RageUI/Menu.lua',
    'src/vendors/RageUI/MenuController.lua',
    'src/vendors/RageUI/components/*.lua',
    'src/vendors/RageUI/elements/*.lua',
    'src/vendors/RageUI/items/*.lua',
    "client/menu.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "shared/*.lua"
}