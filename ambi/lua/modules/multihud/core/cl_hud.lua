Ambi.MultiHUD.huds = Ambi.MultiHUD.huds or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.Packages.Out( 'colors' )
local command = 'ambi_hud_'..Ambi.MultiHUD.Config.command
local convar = CreateClientConVar( command, Ambi.MultiHUD.Config.default_id, true )
local draw_panel = nil

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.MultiHUD.Add( nID, sName, sAuthor, fDraw, fDrawPanel )
    if not nID then return end
    if ( hook.Call( '[Ambi.MultiHUD.CanAdd]', nil, nID, sName, sAuthor, fDraw, fDrawPanel ) == false ) then return end

    Ambi.MultiHUD.huds[ nID ] = {
        name = sName or '',
        author = sAuthor or 'Ambi',
        Draw = fDraw,
        DrawPanel = fDrawPanel,
    }

    hook.Call( '[Ambi.MultiHUD.Added]', nil, nID, sName, sAuthor, fDraw, fDrawPanel )
end

function Ambi.MultiHUD.Remove( nID )
    if not nID then return end
    if ( hook.Call( '[Ambi.MultiHUD.CanRemove]', nil, nID ) == false ) then return end

    local old_tab = Ambi.MultiHUD.huds[ nID ]

    Ambi.MultiHUD.huds[ nID ] = nil

    hook.Call( '[Ambi.MultiHUD.Removed]', nil, nID, old_tab )
end

function Ambi.MultiHUD.Get( nID )
    return Ambi.MultiHUD.huds[ nID ]
end

function Ambi.MultiHUD.GetAll()
    return Ambi.MultiHUD.huds
end

function Ambi.MultiHUD.Set( nID )
    if ( hook.Call( '[Ambi.MultiHUD.CanSet]', nil, nID ) == false ) then return end

    RunConsoleCommand( 'ambi_hud_'..Ambi.MultiHUD.Config.command, nID ) -- Не использую command, чтобы при обновлений конфига, не надо было рестартить

    hook.Call( '[Ambi.MultiHUD.Set]', nil, nID )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'HUDPaint', 'Ambi.MultiHUD.DrawCustomHUD', function()
    if ( Ambi.MultiHUD.Config.enable == false ) then return end
    
    local HUD = Ambi.MultiHUD.huds[ convar:GetInt() ]
    if ( HUD == nil ) then HUD = Ambi.MultiHUD.huds[ 1 ] end

    if HUD.Draw then HUD.Draw() end
end )

hook.Add( 'HUDShouldDraw', 'Ambi.MultiHUD.DontDrawHL2HUD', function( sElement ) 
    if Ambi.MultiHUD.Config.enable then return not Ambi.MultiHUD.Config.block[ sElement ] end
end )

hook.Add( 'HUDDrawTargetID', 'Ambi.MultiHUD.DontDrawTargetID', function() 
    if Ambi.MultiHUD.Config.enable then return not Ambi.MultiHUD.Config.disable_target_id end
end )

hook.Add( 'InitPostEntity', 'Ambi.MultiHUD.DrawCustomPanelHUD', function() 
    timer.Simple( 1, function()
        local hud = Ambi.MultiHUD.Get( convar:GetInt() )
        if hud and hud.DrawPanel then draw_panel = hud.DrawPanel() end
    end )
end )

-- --------------------------------------------------------------------------------------------------------------------------------------------
cvars.AddChangeCallback( command, function( sConVar, sOldValue, sValue )
    if ValidPanel( draw_panel ) then draw_panel:Remove() end

    local hud = Ambi.MultiHUD.Get( tonumber( sValue ) )
    if not hud then return end
    if hud.DrawPanel then draw_panel = hud.DrawPanel() end
end, 'ForDrawPanel' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_multihud_change_hud', function() 
    local arg = net.ReadString()
    if not string.IsValid( arg ) then chat.AddText( C.ERROR, 'Напишите ID худа!' ) return end
    
    local hud = Ambi.MultiHUD.Get( tonumber( arg ) )
    if not hud then chat.AddText( C.ERROR, 'Такого худа не существует! Посмотрите в /huds' ) return end

    Ambi.MultiHUD.Set( arg )
    chat.AddText( C.UK_DARK_GREEN, '[MultiHUD] ', C.ABS_WHITE, 'Вы поставили худ ', C.UK_DARK_GREEN, hud.name )
end )

net.Receive( 'ambi_multihud_show_huds', function() 
    for id, hud in pairs( Ambi.MultiHUD.GetAll() ) do
        chat.AddText( C.UK_DARK_GREEN, id..'. ', C.ABS_WHITE, hud.name )
    end
end )