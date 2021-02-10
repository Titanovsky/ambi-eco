AMB.UI.MainMenu = AMB.UI.MainMenu or {}
AMB.UI.MainMenu.Config = AMB.UI.MainMenu.Config or {}

local C = AMB.G.C

AMB.UI.MainMenu.Config.enable       = false
AMB.UI.MainMenu.Config.call_on_tab  = true
AMB.UI.MainMenu.Config.call_on_f4   = true
AMB.UI.MainMenu.Config.net_f4       = AMB.Network.AddString( 'AmbUIMainMenuShowMenuOnF4' )
AMB.UI.MainMenu.Config.pages = {

    [ 1 ] = { name = 'Page 1', color = C.AMB_RED, draw = function() end },
    [ 2 ] = { name = 'Page 2', color = C.AMB_GREEN, draw = function() end },
    [ 3 ] = { name = 'Page 3', color = C.AMB_BLUE, draw = function() end }

}
AMB.UI.MainMenu.Config.convars = {

    [ 'amb_mm_blur' ]       = { default = 0 },

    [ 'amb_mm_cursor_save' ] = { default = 0 },

    [ 'amb_mm_page_tab' ] = { default = 3 },
    [ 'amb_mm_page_f4' ]  = { default = 0 },
    [ 'amb_mm_page_multi' ] = { default = 0 },
    [ 'amb_mm_page_saves_on_close' ] = { default = 0 },

    [ 'amb_mm_navbar_pos' ] = { default = 'top' },
    [ 'amb_mm_navbar_color0' ] = { default = '56 56 56 60' },
    [ 'amb_mm_navbar_color1' ] = { default = '56 56 56 245' },
    [ 'amb_mm_navbar_color2' ] = { default = '230 157 41 255' },
    [ 'amb_mm_navbar_color3' ] = { default = '243 243 243 10' }

}
AMB.UI.MainMenu.Config.pos_navbar = { x = 0, y = 0, w = 'w', h = 48 }
