local cfg = AMB.UI.MainMenu.Config
local C = AMB.G.C

local w = ScrW()
local h = ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 80 )

local function ShowMenuBind()

    local frame = AMB.UI.GUI.DrawFrame( nil, 640, 320, w/2-320, h/2-320/2, nil, true, true, true )

end
concommand.Add( 'amb_menu_bind', ShowMenuBind )

local function ShowMenuNotify()

    local w_frame, h_frame = w/1.8, h/1.4

    local frame = AMB.UI.GUI.DrawFrame( nil, w_frame, h_frame, w/2-w_frame/2, h/2-h_frame/2, 'Logs of Notifications', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK ) end )
    local panel = AMB.UI.GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall()-48, 0, 24 )
    for id, tab in pairs( AMB.UI.Notify.log_notify ) do
        
        local log = AMB.UI.GUI.DrawPanel( panel, panel:GetWide()-8, panel:GetTall()/12, 4, -44+id*(panel:GetTall()/12+4), function( self, w, h ) 

            draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
            draw.SimpleTextOutlined( tab.time..'  —  '..tab.text, 'Trebuchet18', 8, h/2, C.FLAT_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

        end )

    end

end
concommand.Add( 'amb_menu_notify', ShowMenuNotify )

local page = AMB.UI.MainMenu.Pages.AddPage( 2, 'Настройки', C.AMB_GREEN, C.FLAT_GREEN )
AMB.UI.MainMenu.Pages.SetPage( page, function( vguiFrame ) 

    local frame = AMB.UI.GUI.DrawPanel( vguiFrame, vguiFrame:GetWide(), vguiFrame:GetTall(), 0, 0, function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, C.AMB_BLACK ) end )

    local bind = AMB.UI.GUI.DrawButton( frame, 72, 24, 4, 4, nil, nil, nil, function() 
    
        AMB.UI.MainMenu.RemoveMenu()
        ShowMenuBind()

    end, function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( 'Bind Menu', '12 Ambition', w/2, h/2, C.FLAT_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    AMB.UI.GUI.OnCursorButton( bind, function() bind:SetAlpha( 150 ) end, function() bind:SetAlpha( 255 ) end )

    local notify = AMB.UI.GUI.DrawButton( frame, 72, 24, 4+bind:GetWide()+4, 4, nil, nil, nil, function() 
    
        AMB.UI.MainMenu.RemoveMenu()
        ShowMenuNotify()

    end, function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleText( 'Notify', '12 Ambition', w/2, h/2, C.FLAT_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end )
    AMB.UI.GUI.OnCursorButton( notify, function() notify:SetAlpha( 150 ) end, function() notify:SetAlpha( 255 ) end )

    local checkbox = AMB.UI.GUI.DrawCheckBox( frame, 4, 46, '16 Ambition', C.FLAT_WHITE, '– Окружение за картой (Выкл повышает FPS)', GetConVar('r_3dsky'):GetBool(), 'r_3dsky', true )

end )