Ambi.Base.HUD = Ambi.Base.HUD or {} -- for compatibility
Ambi.Base.huds = Ambi.Base.huds or {}

local command = 'ambi_'..Ambi.Base.Config.hud_command
local convar = CreateClientConVar( command, Ambi.Base.Config.hud_id, true )

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Base.AddHUD( nID, sName, sAuthor, fDraw, fDrawPanel )
    if not nID then return end

    Ambi.Base.huds[ nID ] = {
        name = sName or '',
        author = sAuthor or 'Ambi',
        Draw = fDraw,
        DrawPanel = fDrawPanel,
    }

    hook.Call( '[Ambi.Base.AddedHUD]', nil, nID, sName, sAuthor, fDraw, fDrawPanel )
end
Ambi.Base.HUD.Add = Ambi.Base.AddHUD -- for compatibility

function Ambi.Base.RemoveHUD( nID )
    if not nID then return end

    local old_tab = Ambi.Base.huds[ nID ]

    Ambi.Base.huds[ nID ] = nil

    hook.Call( '[Ambi.Base.RemovedHUD]', nil, nID, old_tab )
end

function Ambi.Base.GetHUD( nID )
    return Ambi.Base.huds[ nID ]
end
Ambi.Base.HUD.Get = Ambi.Base.GetHUD -- for compatibility

function Ambi.Base.GetAllHUD()
    return Ambi.Base.huds
end

function Ambi.Base.SetHUD( nID )
    RunConsoleCommand( 'ambi_'..Ambi.Base.Config.hud_command, nID ) -- Не использую command, чтобы при обновлений конфига, не надо было рестартить
end

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'HUDPaint', 'Ambi.Base.DrawCustomHUD', function()
    if ( Ambi.Base.Config.hud_enable == false ) then return end
    
    local HUD = Ambi.Base.huds[ convar:GetInt() ]
    if ( HUD == nil ) then HUD = Ambi.Base.huds[ 1 ] end

    if HUD.Draw then HUD.Draw() end
end )

hook.Add( 'HUDShouldDraw', 'Ambi.Base.DontDrawHL2HUD', function( sElement ) 
    if Ambi.Base.Config.hud_enable then return not Ambi.Base.Config.hud_block[ sElement ] end
end )

hook.Add( 'HUDDrawTargetID', 'Ambi.Base.DontDrawTargetID', function() 
    if Ambi.Base.Config.hud_enable then return not Ambi.Base.Config.hud_disable_target_id end
end )

local draw_panel = nil

hook.Add( 'InitPostEntity', 'Ambi.Base.DrawCustomPanelHUD', function() 
    timer.Simple( 1, function()
        local hud = Ambi.Base.GetHUD( convar:GetInt() )
        if hud and hud.DrawPanel then draw_panel = hud.DrawPanel() end
    end )
end )

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cvars.AddChangeCallback( command, function( sConVar, sOldValue, sValue )
    if ValidPanel( draw_panel ) then draw_panel:Remove() end

    local hud = Ambi.Base.GetHUD( tonumber( sValue ) )
    if not hud then return end
    if hud.DrawPanel then draw_panel = hud.DrawPanel() end
end, 'ForDrawPanel' )