local C, GUI, Draw, UI, CL = Ambi.Packages.Out( '@d, ContentLoader' )
local W, H = ScrW(), ScrH()
local Add = Ambi.MultiHUD.Add
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
}

-- ---------------------------------------------------------------------------------------------------------------------------------------
Add( 1, 'Ambi HUD', 'Ambi', function()
    -- Health
    local hp, max = LocalPlayer():Health(), LocalPlayer():GetMaxHealth() 
    local color = ( hp <= 30 ) and ColorAlpha( C.AMBI_RED, 200 + math.sin( 360 + CurTime() * 10 ) * 160 ) or C.RED

    local w = ( hp > max ) and 120 or ( 120 / max ) * hp

    Draw.Material( 84, 84 - 14, 18 - 2, H - ( 84 - 14 ) - 10, CL.Material( 'hud1_hp' ), C.BLACK )
    Draw.Material( 84, 84 - 14, 18, H - ( 84 - 14 ) - 10, CL.Material( 'hud1_hp' ), color )

    local color = ( hp <= 30 ) and ColorAlpha( C.AMBI_RED, 200 + math.sin( 360 + CurTime() * 10 ) * 160 ) or C.AMBI_RED
    Draw.Box( 120, 22, 4 - 2, H - 106, C.BLACK, 8 )
    Draw.Box( w - 4, 22 - 4, 4, H - 106 + 2, color, 8 )

    Draw.SimpleText( 62, H - 81, hp, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'bottom-center', 1, C.ABS_BLACK )

    -- Armor
    local value, max = LocalPlayer():Armor(), LocalPlayer():GetMaxArmor() 
    if ( value > 0 ) then
        local w = ( hp > max ) and 120 or ( 120 / max ) * value

        Draw.Material( 76, 76, 150 - 2, H - 76 - 4 + 1, CL.Material( 'hud1_armor' ), C.BLACK )
        Draw.Material( 76, 76, 150, H - 76 - 4, CL.Material( 'hud1_armor' ), C.BLUE )

        Draw.Box( 120, 22, 130 - 2, H - 106, C.BLACK, 8 )
        Draw.Box( w - 4, 22 - 4, 130, H - 104, C.BLUE, 8 )

        Draw.SimpleText( 189, H - 81, value, UI.SafeFont( '28 Ambi' ), C.ABS_WHITE, 'bottom-center', 1, C.ABS_BLACK )
    end

    -- Ammunition
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid( wep ) and not BLOCK_WEAPONS[ wep:GetClass() ] then 
        if ( wep:GetClass() == 'gmod_camera' ) then return end

        Draw.Material( 64, 64, W - 64 - 80 - 1, H - 64 - 60 + 1, CL.Material( 'hud1_ammunition' ), C.BLACK )
        Draw.Material( 64, 64, W - 64 - 80, H - 64 - 60, CL.Material( 'hud1_ammunition' ), C.GREEN )

        local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
        local ammo = clip1..'/'..ammo1
        if ammo2 and ( ammo2 > 0 ) then 
            ammo = '('..ammo2..') '..clip1..'/'..ammo1
        end

        local color = ( ammo1 == 0 and clip1 == 0 ) and C.AMBI_GRAY or C.WHITE
        Draw.SimpleText( W - 102, H - 38, wep:GetClass(), UI.SafeFont( '23 Arial' ), color, 'bottom-center', 1, C.ABS_BLACK )
        Draw.SimpleText( W - 102, H - 2, ammo, UI.SafeFont( '38 Ambi' ), color, 'bottom-center', 1, C.ABS_BLACK )
    end
end )