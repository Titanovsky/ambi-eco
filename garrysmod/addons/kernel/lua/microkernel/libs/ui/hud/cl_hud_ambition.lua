local w = ScrW()
local h = ScrH()

local C = AMB.G.C
local COLOR_PANEL = Color( 20, 20, 20, 200 )
local COLOR_FIRST_PANEL = Color( 20, 20, 20, 150 )
local COLOR_BLOOD = Color( 128, 65, 60 )
local COLOR_ARMOR = Color( 172, 179, 191 )
local panel = {

    w = 240,
    h = 100,
    margin = 4,
    h2 = 24,
    margin2 = 80,

}

AMB.UI.HUD.RegisterHUD( 1, 'Ambition HUD', 'A M B I T I O N', function()

    if not LocalPlayer():Alive() then return end

    local hp = ( LocalPlayer():Health() <= 100 ) and LocalPlayer():Health() or 100
    local hp_color = ( LocalPlayer():Health() <= 40 ) and Color( 255, 0, 0, math.sin( 360 + CurTime() * 6 ) * 155 ) or C.FLAT_WHITE
    local armor = ( LocalPlayer():Armor() <= 100 ) and LocalPlayer():Armor() or 100

    draw.RoundedBox( 0, panel.margin, h-panel.h-panel.margin, panel.w, panel.h, COLOR_FIRST_PANEL )

    -- NickName
    draw.RoundedBox( 0, panel.margin, h-panel.h-panel.margin, panel.w, panel.h/5, COLOR_PANEL )

    draw.SimpleTextOutlined( string.sub( LocalPlayer():Nick(), 1, 22 ), '17 Ambition', 12, h-94, C.FLAT_WHITE, 
    TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    -- Main Info
    draw.RoundedBox( 0, panel.margin, h-panel.h-panel.margin+22, panel.w-60, panel.h-22, COLOR_PANEL )

    draw.RoundedBox( 4, 14, h-78, 32, 32, COLOR_BLOOD )
    draw.RoundedBox( 4, 14, h-46-hp/3, 32, hp/3, C.FLAT_RED )
    draw.SimpleTextOutlined( LocalPlayer():Health(), '12 Ambition', 30, h-56, hp_color, 
    TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    draw.RoundedBox( 4, 50, h-78, 32, 32, C.FLAT_GRAY )
    draw.RoundedBox( 4, 50, h-46-armor/3, 32, armor/3, C.FLAT_BLUE )

    -- Ammo
    draw.RoundedBox( 0, panel.margin+182, h-panel.h-panel.margin+22, panel.w-182, panel.h-22, COLOR_PANEL )

    draw.SimpleTextOutlined( 'AMMO', '12 Ambition', 214, h-72, C.AMBITION, 
    TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    if ( armor > 0 ) then 
    
        draw.SimpleTextOutlined( LocalPlayer():Armor(), '12 Ambition', 66, h-56, C.FLAT_WHITE, 
        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK ) 

    end

    if IsValid( LocalPlayer():GetActiveWeapon() ) then

        draw.SimpleTextOutlined( LocalPlayer():GetActiveWeapon():Clip1()..'/'..LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() ), '12 Ambition', 214, h-46, C.FLAT_WHITE, 
        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )


        draw.SimpleTextOutlined( '('..LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType() )..')', '12 Ambition', 214, h-30, C.FLAT_WHITE, 
        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    end

    draw.RoundedBox( 0, panel.margin, h-panel.h-panel.margin, 6, panel.h, C.AMBITION ) -- side panel

end )