local cfg = AMB.UI.MainMenu.Config
local C = AMB.G.C

local w = ScrW()
local h = ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 80 )

surface.SetFont( '32 Ambition' )
local xchar, _ = surface.GetTextSize( GetHostName() )

local page = AMB.UI.MainMenu.Pages.AddPage( 1, 'Инфо', C.AMB_RED, C.FLAT_RED )
AMB.UI.MainMenu.Pages.SetPage( page, function( vguiFrame ) 

    local frame = AMB.UI.GUI.DrawPanel( vguiFrame, vguiFrame:GetWide(), vguiFrame:GetTall(), 0, 0, function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, C.AMB_BLACK ) end )

    local server_panel = AMB.UI.GUI.DrawPanel( frame, frame:GetWide()-8, 38, 4, 4, function( self, w, h ) 
    
        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( GetHostName(), '32 Ambition', w/2+2, h/2+2, C.ABS_BLACK, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        draw.SimpleText( GetHostName(), '32 Ambition', w/2, h/2, C.AMBITION, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        
    end )

    local avatar_panel = AMB.UI.GUI.DrawPanel( frame, 132, 132, 4, 48, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.ABS_BLACK ) end )
    local avatar = AMB.UI.GUI.DrawAvatar( avatar_panel, 128, 128, 2, 2, LocalPlayer(), 128 )
    local avatar_button = AMB.UI.GUI.DrawButton( avatar, avatar:GetWide(), avatar:GetTall(), 0, 0, nil, nil, nil, function() gui.OpenURL( 'http://steamcommunity.com/profiles/'..LocalPlayer():SteamID64() ) end, function() end )

    AMB.UI.GUI.DrawText( frame, 4+avatar_panel:GetWide()+10, 50, '26 Ambition', C.ABS_BLACK, '['..LocalPlayer():EntIndex()..']'..' '..LocalPlayer():Nick(), true ) -- shadow
    local nick = AMB.UI.GUI.DrawText( frame, 4+avatar_panel:GetWide()+8, 48, '26 Ambition', C.FLAT_WHITE, '['..LocalPlayer():EntIndex()..']'..' '..LocalPlayer():Nick(), true )

    local info_panel = AMB.UI.GUI.DrawGrid( frame, 200, 24, 144, 88, 1 )

    surface.SetFont( '18 Ambition' )
    local xchar, _ = surface.GetTextSize( LocalPlayer():SteamID() )

    local steamid = AMB.UI.GUI.DrawButton( nil, xchar+12, 20, 0, 0, nil, nil, nil, function() SetClipboardText( LocalPlayer():SteamID() ) end, function( self, w, h ) 
        
        draw.RoundedBox( 6, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( LocalPlayer():SteamID(), '18 Ambition', w/2, h/2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    info_panel:AddItem( steamid )

    local xchar, _ = surface.GetTextSize( LocalPlayer():SteamID64() )

    local steamid64 = AMB.UI.GUI.DrawButton( nil, xchar+12, 20, 0, 0, nil, nil, nil, function() SetClipboardText( LocalPlayer():SteamID64() ) end, function( self, w, h ) 
        
        draw.RoundedBox( 6, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( LocalPlayer():SteamID64(), '18 Ambition', w/2, h/2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    info_panel:AddItem( steamid64 )

    local xchar, _ = surface.GetTextSize( game.GetIPAddress() )

    local ip = AMB.UI.GUI.DrawButton( nil, xchar+12, 20, 0, 0, nil, nil, nil, function() SetClipboardText( game.GetIPAddress() ) end, function( self, w, h ) 
        
        draw.RoundedBox( 6, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( game.GetIPAddress(), '18 Ambition', w/2, h/2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    info_panel:AddItem( ip )

    local xchar, _ = surface.GetTextSize( team.GetName( LocalPlayer():Team() ) )

    local team = AMB.UI.GUI.DrawButton( nil, xchar+12, 20, 0, 0, nil, nil, nil, function() SetClipboardText( LocalPlayer():Team() ) end, function( self, w, h ) 
        
        draw.RoundedBox( 6, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( team.GetName( LocalPlayer():Team() ), '18 Ambition', w/2, h/2, C.ABS_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    info_panel:AddItem( team )

end )