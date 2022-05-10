-- TODO: Rewrite
local C = Ambi.General.Global.Colors
local HUD = Ambi.Base.HUD

local w = ScrW()
local h = ScrH()
local COLOR_PANEL = Color( 20, 20, 20, 200 )

HUD.Add( 2, 'Minimalistic HUD', 'Ambi', function()
    surface.SetFont( '28 Ambi' )
    local xchar_nick, _ = surface.GetTextSize( '['..LocalPlayer():EntIndex()..']'..' '..LocalPlayer():Nick() )

    surface.SetFont( '18 Ambi' )
    local xchar_hp, _ = surface.GetTextSize( 'Health: '..LocalPlayer():Health() )
    local xchar_armor, _ = surface.GetTextSize( 'Armor: '..LocalPlayer():Armor() )

    draw.RoundedBox( 4, 4, h-32-4, xchar_nick+20, 32, COLOR_PANEL )
    draw.SimpleTextOutlined( '['..LocalPlayer():EntIndex()..']'..' '..LocalPlayer():Nick(), '28 Ambi Bold', 6, h-32, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    draw.RoundedBox( 4, 4, h-56, xchar_hp+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( 'Health: '..LocalPlayer():Health(), '18 Ambi', 8, h-55, C.FLAT_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    draw.RoundedBox( 4, 4, h-56-10*2, xchar_armor+8, 18, COLOR_PANEL )
    draw.SimpleTextOutlined( 'Armor: '..LocalPlayer():Armor(), '18 Ambi', 8, h-55-10*2, C.FLAT_BLUE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
end )