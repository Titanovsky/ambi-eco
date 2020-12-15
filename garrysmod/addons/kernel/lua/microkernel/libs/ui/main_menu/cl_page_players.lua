local cfg = AMB.UI.MainMenu.Config
local C = AMB.G.C

local w = ScrW()
local h = ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 80 )

local page = AMB.UI.MainMenu.Pages.AddPage( 3, 'Игроки', C.AMB_BLUE, C.FLAT_BLUE )
AMB.UI.MainMenu.Pages.SetPage( page, function( vguiFrame ) 

    local frame = AMB.UI.GUI.DrawScrollPanel( vguiFrame, vguiFrame:GetWide(), vguiFrame:GetTall(), 0, 0, function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, C.AMB_BLACK ) end )
    local sbar = frame:GetVBar()
    sbar:SetSize( 0, 0 )

    for id, ply in pairs( player.GetAll() ) do
        
        local panel = AMB.UI.GUI.DrawButton( frame, frame:GetWide(), 38, 0, 40*id-40, nil, nil, nil, function() 
        
            SetClipboardText( ply:SteamID() )
            gui.OpenURL( 'http://steamcommunity.com/profiles/'..ply:SteamID64() )
            
         end, function( self, w, h ) 
        
            draw.RoundedBox( 4, 0, 0, w, h, self.color ) 
            draw.SimpleText( id, '20 Ambition', 8, h/2, C.AMB_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            draw.SimpleText( ply:Nick(), '20 Ambition', 48, h/2, C.AMB_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            draw.SimpleText( 'P:'..ply:Ping()..' K:'..ply:Frags()..' D:'..ply:Deaths(), '16 Ambition', w-8, h/2, C.AMB_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

        end )
        panel.color = COLOR_PANEL
        
        panel.OnCursorEntered = function( self )

            self.color = ColorAlpha( self.color, 120 )

        end
        panel.OnCursorExited = function( self )

            self.color = ColorAlpha( self.color, 80 )

    	end

    end

end )