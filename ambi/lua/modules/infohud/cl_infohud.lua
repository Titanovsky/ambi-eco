-- TODO: Rewrite and clear!
local Gen, C, NW, Notify = Ambi.General, AMB.General.Global.Colors, Ambi.NW, Ambi.UI.Notify
local C, GUI, Draw, UI = Ambi.Packages.Out( '@d' )
local W, H = ScrW(), ScrH()

local CFG = Ambi.InfoHUD.Config
local w, h = ScrW(), ScrH()

local FONT, FONT_NUM = 'InfoHUD_Main', 'InfoHUD_Numbers'
local INDENT, MARGIN, POS_Y = 4, 28, 90
local count = CreateClientConVar( 'ambi_infohud', 0, true )

local weaponClassTouchTypes = {
    ["weapon_physgun"] = "Physgun",
    ["weapon_physcannon"] = "Gravgun",
    ["gmod_tool"] = "Toolgun",
}
local COLOR_BACK1, COLOR_BACK2 = ColorAlpha( C.ABS_BLACK, 200 ), ColorAlpha( C.ABS_BLACK, 240 )

-- --------------------------------------------------------------------------------------------------------------------------------------------
UI.AddFont( FONT, { font = 'Franklin Gothic Demi', size = 26, extended = true } )
UI.AddFont( FONT_NUM, { font = 'Franklin Gothic Demi', size = 24, extended = true } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function GetNamePlayer( ePly )
    return ePly:Nick()
end

local function GetOwnerString( eObj )
    if eObj:IsPlayer() then return GetNamePlayer( eObj ) end
    if eObj.CPPIGetOwner then  
        if eObj:CPPIGetOwner() then return eObj:CPPIGetOwner():Nick() end

        return Ambi.InfoHUD.Config.title_world
    end
    
    if not NW.GetString( eObj, 'PropCoreOwnerName' ) then return '-' end

    local owner = ( #NW.GetString( eObj, 'PropCoreOwnerName' ) == 0 ) and AMB.InfoHUD.Config.title_world or NW.GetString( eObj, 'PropCoreOwnerName' )
    if ( #NW.GetString( eObj, 'PropCoreOwnerName' ) == 0 ) then
        return AMB.InfoHUD.Config.title_world
    else
        if NW.GetEntity( eObj, 'PropCoreOwner' ) and IsValid( NW.GetEntity( eObj, 'PropCoreOwner' ) ) then return NW.GetString( eObj, 'PropCoreOwnerName' ) end

        return NW.GetString( eObj, 'PropCoreOwnerName' )..' (Disconnected)'
    end
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'HUDPaint', 'Ambi.InfoHUD.Draw', function()
    if ( count:GetInt() == 0 ) then return end

    local trace = LocalPlayer():GetEyeTrace()
    if not IsValid( trace.Entity ) then return end

    local ent = trace.Entity
    if ( LocalPlayer():GetPos():Distance( ent:GetPos() ) > Ambi.InfoHUD.Config.min_distance ) then return end

    surface.SetFont( FONT )
    local text = GetOwnerString( ent )
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = 0

    local wep = LocalPlayer():GetActiveWeapon()
    local color = ( Ambi.InfoHUD.Config.fpp_enable and FPP ) and ( FPP.canTouchEnt( ent, weaponClassTouchTypes[ wep:IsValid() and wep:GetClass() or "" ] or 'EntityDamage' ) and C.AMBI_GREEN or C.AMBI_RED ) or C.ABS_WHITE
    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 4 + ( MARGIN * multiply_y ), color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '0', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    surface.SetFont( FONT )
    local name = ent:IsPlayer() and GetNamePlayer( ent ) or ent:GetClass()
    local text = name..' ['..ent:EntIndex()..']'
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 4 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '1', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 2 ) then return end

    surface.SetFont( FONT )
    local vec_x, vec_y, vec_z = math.Round( ent:GetPos().x ), math.Round( ent:GetPos().y ), math.Round( ent:GetPos().z )
    local text = vec_x..'  '..vec_y..'  '..vec_z
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '2', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 3 ) then return end

    surface.SetFont( FONT )
    local ang_x, ang_y, ang_z = math.Round( ent:GetAngles().x ), math.Round( ent:GetAngles().y ), math.Round( ent:GetAngles().z )
    local text = ang_x..'  '..ang_y..'  '..ang_z
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '3', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 4 ) then return end

    surface.SetFont( FONT )
    local col_r, col_g, col_b, col_a = ent:GetColor().r, ent:GetColor().g, ent:GetColor().b, ent:GetColor().a
    local text = col_r..' '..col_g..' '..col_b..' '..col_a
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '4', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 5 ) then return end

    surface.SetFont( FONT )
    local text = ent:GetModel() or 'No Model'
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '5', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 6 ) then return end

    surface.SetFont( FONT )
    local text = ( #ent:GetMaterial() > 0 ) and ent:GetMaterial() or 'No Material'
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '6', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 7 ) then return end

    surface.SetFont( FONT )
    local text = 'Health '..ent:Health()
    local xw, _ = surface.GetTextSize( text )
    if ent:IsPlayer() then 
        text = 'Health '..ent:Health()..'  Armor '..ent:Armor() 
        xw, _ = surface.GetTextSize( text )
    end

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '7', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 8 ) then return end

    surface.SetFont( FONT )
    local text = ent:IsPlayer() and ent:SteamID() or 'SteamID X'
    if ent:IsPlayer() and ent:IsBot() then text = 'SteamID X' end
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '8', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

    if ( count:GetInt() < 9 ) then return end

    surface.SetFont( FONT )
    local lvec = ent:WorldToLocal( trace.HitPos )
    local lvec_x, lvec_y, lvec_z = math.Round( lvec.x ), math.Round( lvec.y ), math.Round( lvec.z )
    local text = lvec_x..'  '..lvec_y..'  '..lvec_z
    local xw, _ = surface.GetTextSize( text )

    local multiply_y = multiply_y + 1

    draw.RoundedBox( 4, w - xw - 8 - INDENT, h / 2 - POS_Y + ( MARGIN * multiply_y ), xw + 8, 26, COLOR_BACK1 )
    draw.SimpleText( text, FONT, w - 8, h / 2 - POS_Y + 5 + ( MARGIN * multiply_y ), C.AMBI_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.RoundedBox( 4, w - xw - 8 - INDENT - 20 - INDENT / 2, h / 2 - POS_Y + ( MARGIN * multiply_y ), 20, 26, COLOR_BACK2 )
    draw.SimpleText( '9', FONT_NUM, w - INDENT - xw - 16, h / 2 - POS_Y + 3 + ( MARGIN * multiply_y ), C.AMBI, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
end )

local can_notify = true
local delay_for_notify = 0.65

local function SendNotify( sText )
    if not CFG.notify_enable then return end
    if not can_notify then return end

    can_notify = false
    Notify.Draw( CFG.notify_id, { text = sText, time = 4, color = C.AMB_GREEN } )

    timer.Simple( delay_for_notify, function() can_notify = true end )
end

local function GetEntity()
    local trace = LocalPlayer():GetEyeTrace()
    local ent = trace.Entity

    if not IsValid( ent ) then return end

    return ent
end

hook.Add( 'PlayerButtonDown', 'AMB.InfoHUD.CopyInfoFromPanel', function()
    if input.IsKeyDown( KEY_PAD_1 ) and ( count:GetInt() >= 1 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( ent:IsPlayer() and GetNamePlayer( ent ) or ent:GetClass() )

        SendNotify( ent:IsPlayer() and 'Игровое Имя скопировано!' or 'Класс скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_2 ) and ( count:GetInt() >= 2 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( math.Round( ent:GetPos().x )..', '..math.Round( ent:GetPos().y )..', '..math.Round( ent:GetPos().z ) )

        SendNotify( 'Вектор скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_3 ) and ( count:GetInt() >= 3 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( math.Round( ent:GetAngles().x )..', '..math.Round( ent:GetAngles().y )..', '..math.Round( ent:GetAngles().z ) )

        SendNotify( 'Углы скопированы!' )
    elseif input.IsKeyDown( KEY_PAD_4 ) and ( count:GetInt() >= 4 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( ent:GetColor()[ 'r' ]..', '..ent:GetColor()[ 'g' ]..', '..ent:GetColor()[ 'b' ]..', '..ent:GetColor()[ 'a' ] )

        SendNotify( 'Цвет скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_5 ) and ( count:GetInt() >= 5 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( ent:GetModel() )

        SendNotify( 'Модель скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_6 ) and ( count:GetInt() >= 6 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( ent:GetMaterial() )

        SendNotify( 'Материал скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_7 ) and ( count:GetInt() >= 7 ) then
        local ent = GetEntity()
        if not ent then return end

        SetClipboardText( ent:Health() )

        SendNotify( 'Кол-во Здоровья скопировано!' )
    elseif input.IsKeyDown( KEY_PAD_8 ) and ( count:GetInt() >= 8 ) then
        local ent = GetEntity()
        if not ent then return end
        if ent:IsPlayer() and ent:IsBot() then return end

        SetClipboardText( ent:SteamID() )

        SendNotify( 'SteamID скопирован!' )
    elseif input.IsKeyDown( KEY_PAD_9 ) and ( count:GetInt() >= 9 ) then
        local ent = GetEntity()
        if not ent then return end

        local lvec = ent:WorldToLocal( LocalPlayer():GetEyeTrace().HitPos )
        SetClipboardText( math.Round( lvec.x )..', '..math.Round( lvec.y )..', '..math.Round( lvec.z ) )

        SendNotify( 'Вектор скопирован!' )
    end
end )