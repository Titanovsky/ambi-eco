local C, GUI, Draw = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()
local HUD = Ambi.Base.HUD
local COLOR_PANEL = Color( 46, 46, 46 )

local MAT_HEALTH_NAME, MAT_HEALTH_URL = 'health_hud1.png', 'https://i.ibb.co/xDcS9JS/health.png'
local MAT_HEALTH = Material( Ambi.Cache.GetCacheFile( MAT_HEALTH_NAME ) )

local MAT_ARMOR_NAME, MAT_ARMOR_URL = 'armor_hud1.png', 'https://i.ibb.co/GQjdY6d/armor.png'
local MAT_ARMOR = Material( Ambi.Cache.GetCacheFile( MAT_ARMOR_NAME ) )

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

HUD.Add( 1, 'Main HUD', 'Ambi', function()
    if not LocalPlayer():Alive() then return end

    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid( wep ) and not BLOCK_WEAPONS[ wep:GetClass() ] then 
        if ( wep:GetClass() == 'gmod_camera' ) then return end

        local clip1, ammo1, ammo2 = wep:Clip1(), LocalPlayer():GetAmmoCount( wep:GetPrimaryAmmoType() ), LocalPlayer():GetAmmoCount( wep:GetSecondaryAmmoType() )
        local ammo = clip1..' / '..ammo1
        if ammo2 and ( ammo2 > 0 ) then 
            ammo = '('..ammo2..') '..clip1..' / '..ammo1
        end

        local color = ( ammo1 == 0 and clip1 == 0 ) and C.AMBI_GRAY or C.AMBI
        Draw.SimpleText( W - 4, 22, ammo, '44 Ambi', color, 'top-right', 1, C.ABS_BLACK )
    end

    Draw.Box( W, 24, 0, 0, C.AMBI_BLACK )
    Draw.Box( W, 4, 0, 20, COLOR_PANEL )
    Draw.SimpleText( W / 2, 0, GetHostName(), '20 Ambi', C.AMBI, 'top-center', 1, C.ABS_BLACK )

    if MAT_HEALTH:IsError() then 
        Ambi.Cache.CacheURL( MAT_HEALTH_NAME, MAT_HEALTH_URL, 4 )
        MAT_HEALTH = Material( Ambi.Cache.GetCacheFile( MAT_HEALTH_NAME ) )
    else
        local hp, max = LocalPlayer():Health(), LocalPlayer():GetMaxHealth() 
        local color = ( hp <= 30 ) and ColorAlpha( C.AMBI_RED, 200 + math.sin( 360 + CurTime() * 10 ) * 160 ) or C.ABS_WHITE

        Draw.Material( 64, 48, 16, 26, MAT_HEALTH, color )

        local w = ( hp > max ) and 84 or ( 84 / max ) * hp

        local color = ( hp <= 30 ) and ColorAlpha( C.AMBI_RED, 200 + math.sin( 360 + CurTime() * 10 ) * 160 ) or C.AMBI_RED
        Draw.Box( 86, 10, 3, 74, C.AMBI_BLACK )
        Draw.Box( w, 8, 4, 75, color )

        if ( hp > max ) then
            Draw.SimpleText( 49, 74, hp, '12 Arial', C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
        end
    end

    local armor, max = LocalPlayer():Armor(), LocalPlayer():GetMaxArmor() 
    if ( armor > 0 ) then
        if MAT_ARMOR:IsError() then 
            Ambi.Cache.CacheURL( MAT_ARMOR_NAME, MAT_ARMOR_URL, 4 )
            MAT_ARMOR = Material( Ambi.Cache.GetCacheFile( MAT_ARMOR_NAME ) )
        else

            Draw.Material( 50, 46, 114, 26, MAT_ARMOR )

            local w = ( armor > max ) and 84 or ( 84 / max ) * armor

            Draw.Box( 86, 10, 94, 74, C.AMBI_BLACK )
            Draw.Box( w, 8, 95, 75, C.AMBI_BLUE )

            if ( armor > max ) then
                Draw.SimpleText( 139, 74, armor, '12 Arial', C.ABS_WHITE, 'top-center', 1, C.ABS_BLACK )
            end
        end
    end
end )