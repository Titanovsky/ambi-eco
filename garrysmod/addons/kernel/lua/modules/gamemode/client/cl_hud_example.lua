local w = ScrW()
local h = ScrH()
local C = AMB.G.C

local hud = nil

AMB.UI.HUD.RegisterHUD( 3, 'Example HUD', 'A M B I T I O N', function() 

    if ValidPanel( hud ) then return end

    hud = vgui.Create( 'DFrame' )
    hud:SetSize( 200, 200 )
    hud:SetPos( w/2 - hud:GetWide()/2, h - hud:GetTall() - 4 )
    hud:SetTitle( '' )
    hud:ShowCloseButton( true )
    hud.Paint = function( self, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, C.AMB_PANEL )

        draw.SimpleTextOutlined( LocalPlayer():Nick(), 'Trebuchet24', 4, 4, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, .8, C.FLAT_DARK_PURPLE )
        draw.SimpleTextOutlined( '1. Health: '..AMB.Stats.GetStats( LocalPlayer(), 'health' ), 'Trebuchet18', 4, 32, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( '2. Armor: '..AMB.Stats.GetStats( LocalPlayer(), 'armor' ), 'Trebuchet18', 4, 32 + 14 * 1, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( '3. Walk Speed: '..AMB.Stats.GetStats( LocalPlayer(), 'walkspeed' ), 'Trebuchet18', 4, 32 + 14 * 2, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
        draw.SimpleTextOutlined( '4. Run Speed: '..AMB.Stats.GetStats( LocalPlayer(), 'runspeed' ), 'Trebuchet18', 4, 32 + 14 * 3, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    end

end )

cvars.AddChangeCallback( AMB.UI.HUD.convar, function( convar_name, value_old, value_new )

    if ValidPanel( hud ) then hud:Remove() return end

end )

