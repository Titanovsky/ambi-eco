local C, GUI, Draw, UI, Lang = Ambi.Packages.Out( '@d, language' )
local MultiHUD = Ambi.MultiHUD

local W, H = ScrW(), ScrH()
local W_PANELS = 200
local COLOR_PANEL = Color( 20, 20, 20, 200 )
local COLOR_BLOOD = Color( 137, 3 ,3 ,209 )
local COLOR_DARK_BLUE = Color( 56, 70 ,123 ,209)
local BLOCK_WEAPONS = {
    [ 'weapon_physcannon' ] = true,
    [ 'weapon_bugbait' ] = true,
    [ 'weapon_crowbar' ] = true,
    [ 'weapon_stunstick' ] = true,
    [ 'weapon_fists' ] = true,
    [ 'weapon_physgun' ] = true,
    [ 'gmod_tool' ] = true,
    [ 'keys' ] = true,
    [ 'lockpick' ] = true,
    [ 'stunstick' ] = true,
    [ 'arrest_stick' ] = true,
    [ 'unarrest_stick' ] = true,
    [ 'weaponchecker' ] = true,
    [ 'keypadchecker' ] = true,
    [ 'gmod_camera' ] = true,
}

-- --------------------------------------------------------------------------------------------------------------------------------------------
UI.AddFont( 'AmbiMinHUD', { font = 'Franklin Gothic Demi', size = 48, extended = true, weight = 100 } )
UI.AddFont( 'AmbiMinHUDAmmo', { font = 'Franklin Gothic Demi', size = 64, extended = true } )
UI.AddFont( 'AmbiMinHUDHealth', { font = 'Franklin Gothic Demi', size = 32, extended = true } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
MultiHUD.Add( 2, 'Minimalistic HUD', 'Ambi', function()
    -- Nick
    local nick = LocalPlayer():Nick()
    local w_nick = Draw.GetTextSizeX( 'AmbiMinHUD', nick ) + 8
    Draw.Box( w_nick, 36, 10, H - 36 - 10, COLOR_PANEL, 4 )
    Draw.SimpleText( 14, H - 4, nick, 'AmbiMinHUD', C.WHITE, 'bottom-left', 1, C.ABS_BLACK )

    -- Health
    local hp, max = LocalPlayer():Health(), LocalPlayer():GetMaxHealth()
    local w = ( hp > max ) and W_PANELS or ( W_PANELS / max ) * hp
    local color = ( hp <= ( max / 3 ) ) and ColorAlpha( COLOR_BLOOD, 200 + math.sin( 360 + CurTime() * 16 ) * 160 ) or COLOR_BLOOD
    local color2 = ( hp <= ( max / 3 ) ) and ColorAlpha( C.RED, 200 + math.sin( 360 + CurTime() * 16 ) * 160 ) or C.RED

    Draw.Box( W_PANELS + 8, 36, 10, H - 36 - 50, COLOR_PANEL, 4 )
    Draw.Box( W_PANELS, 36 - 8, 10 + 4, H - 36 - 50 + 4, color, 4 )
    Draw.Box( w, 36 - 8, 10 + 4, H - 36 - 50 + 4, color2, 4 )
    Draw.SimpleText( 120, H - 52, hp, 'AmbiMinHUDHealth', C.ABS_WHITE, 'bottom-center', 1, C.ABS_BLACK )

    -- Armor
    local armor, max = LocalPlayer():Armor(), LocalPlayer():GetMaxArmor()
    if ( armor > 0 ) then
        local w = ( armor > max ) and W_PANELS or ( W_PANELS / max ) * armor

        Draw.Box( W_PANELS + 8, 36, 10, H - 36 - 90, COLOR_PANEL, 4 )
        Draw.Box( W_PANELS, 36 - 8, 10 + 4, H - 36 - 90 + 4, COLOR_DARK_BLUE, 4 )
        Draw.Box( w, 36 - 8, 10 + 4, H - 36 - 90 + 4, C.BLUE, 4 )
        Draw.SimpleText( 120, H - 92, armor, 'AmbiMinHUDHealth', C.ABS_WHITE, 'bottom-center', 1, C.ABS_BLACK )
    end

    -- Ammunition
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid( wep ) and not BLOCK_WEAPONS[ wep:GetClass() ] then 
        local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
        local ammo = clip1..' / '..ammo1
        if ammo2 and ( ammo2 > 0 ) then 
            ammo = '('..ammo2..') '..clip1..' / '..ammo1
        end

        local color = ( ammo1 == 0 and clip1 == 0 ) and C.AMBI_GRAY or C.WHITE
        Draw.SimpleText( W - 4, H - 1, ammo, 'AmbiMinHUDAmmo', color, 'bottom-right', 1, C.ABS_BLACK )
    end
end )