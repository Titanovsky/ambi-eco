AMB.UI.MainMenu = AMB.UI.MainMenu or {}
AMB.UI.MainMenu.Config = AMB.UI.MainMenu.Config or {}

local C = AMB.G.C
local PREFIX = AMB.Config.prefix

AMB.UI.MainMenu.Config.enable       = false
AMB.UI.MainMenu.Config.call_on_tab  = true
AMB.UI.MainMenu.Config.call_on_f4   = true
AMB.UI.MainMenu.Config.net_f4       = AMB.Network.AddString( 'amb_ui_mainmenu_show_menu_on_f4' )
AMB.UI.MainMenu.Config.pages = AMB.UI.MainMenu.Config.pages or {

    [ 1 ] = { name = 'Example Page', color = C.AMB_RED, draw = function() end }

}
AMB.UI.MainMenu.Config.convars = {

    [ 'amb_mm_'..PREFIX..'_blur' ] = { default = 0 },

    [ 'amb_mm_'..PREFIX..'_cursor_save' ] = { default = 0 },

    [ 'amb_mm_'..PREFIX..'_page_tab' ] = { default = 1 },
    [ 'amb_mm_'..PREFIX..'_page_f4' ]  = { default = 0 },
    [ 'amb_mm_'..PREFIX..'_page_multi' ] = { default = 0 },
    [ 'amb_mm_'..PREFIX..'_page_save' ] = { default = 0 },

    [ 'amb_mm_'..PREFIX..'_navbar_pos' ] = { default = 'top' },
    [ 'amb_mm_'..PREFIX..'_navbar_color0' ] = { default = '56 56 56 60' },
    [ 'amb_mm_'..PREFIX..'_navbar_color1' ] = { default = '56 56 56 245' },
    [ 'amb_mm_'..PREFIX..'_navbar_color3' ] = { default = '243 243 243 10' }

}
AMB.UI.MainMenu.Config.pos_navbar = { x = 0, y = 0, w = 'w', h = 54 }
