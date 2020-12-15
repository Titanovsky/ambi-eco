AMB.Gamemode = AMB.Gamemode or {}
local CFG = AMB.Gamemode.Config

local w = ScrW()
local h = ScrH()
local C = AMB.G.C

function AMB.Gamemode.BlockHUDLibrary()

    hook.Remove( 'HUDPaint', 'AMB.UI.HUD.DrawCustomHUD' )
    hook.Remove( 'HUDShouldDraw', 'AMB.UI.HUD.DontDrawHL2HUD' )
    hook.Remove( 'HUDDrawTargetID', 'AMB.UI.HUD.DontDrawTargetID' )

end

function AMB.Gamemode.StartMenu()

    local frame = AMB.UI.GUI.DrawFrame( nil, w/1.4, h/1.4, 0, 0, '', true, false, true, function( self, w, h ) draw.RoundedBox( 2, 0, 0, w, h, C.AMB_BLACK ) end )
    frame:Center()

    local button = AMB.UI.GUI.DrawButton( frame, frame:GetWide()/6, frame:GetTall()/6, frame:GetWide()/2-(frame:GetWide()/6)/2, frame:GetTall()-frame:GetTall()/6-4, '24 Ambition Bold', C.AMBITION, 'Start', function() frame:Remove() end, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMB_PANEL ) end )

end

hook.Add( 'InitPostEntity', 'AMB.Gamemode.ClientsLoad', function() 

    if CFG.start_menu then AMB.Gamemode.StartMenu() end
    if not CFG.use_hud_library then AMB.Gamemode.BlockHUDLibrary() end

end )
