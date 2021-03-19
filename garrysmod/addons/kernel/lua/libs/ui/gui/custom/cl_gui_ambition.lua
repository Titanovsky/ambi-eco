AMB.UI.GUI.Ambition = AMB.UI.GUI.Ambition or {}

local C = AMB.G.C

function AMB.UI.GUI.Ambition.DrawFrame( vguiParent, wSize, hSize, xPos, yPos, sTitle, sTooltip, fRemove )

    wSize       = wSize or 0
    hSize       = hSize or 0
    xPos        = xPos or 0
    yPos        = yPos or 0
    sTitle      = sTitle or ''
    sTooltip    = sTooltip or 'ⓘ'

    local frame = vgui.Create( 'DPanel', vguiParent )
    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame.Paint = function( self, w, h ) end

    local header = vgui.Create( 'DPanel', frame )
    header:SetSize( frame:GetWide(), 32 )
    header:SetPos( 0, 0 )
    header.Paint = function( self, w, h ) 

        draw.RoundedBoxEx( 8, 0, 0, w, h, C.AMBITION, true, true ) 
        draw.SimpleTextOutlined( sTitle, '32 Ambition Bold', 6, h + 2, C.AMB_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, C.ABS_BLACK )

    end

    local close = vgui.Create( 'DButton', header )
    close:SetSize( 26, 26 )
    close:SetPos( header:GetWide() - 26 - 6, header:GetTall() - 26 - 2 )
    close:SetText( '' )
    close.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, C.AMB_BLACK )
        draw.SimpleText( '☓', '16 Ambition', w / 2 - 1, h / 2, C.AMB_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    end
    close.DoClick = function()

        if fRemove then fRemove() end
        frame:Remove()

    end

    local info = vgui.Create( 'DButton', header )
    info:SetSize( 26, 26 )
    info:SetPos( header:GetWide() - 6 - close:GetWide() - 26 - 2, header:GetTall() - 26 - 2 )
    info:SetText( '' )
    info:SetTooltip( sTooltip )
    info.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, C.AMB_BLACK )
        draw.SimpleText( 'ⓘ', '16 Ambition', w / 2 - 1, h / 2, C.AMB_GRAY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    end

    vguiParent:Receiver( 'change_position_frame', function( vguiReceiver, tDroppedPanel, bDropped, nMenuIndex, xMouse, yMouse ) 

        frame:SetPos( xMouse - frame:GetWide() / 2 + 8, yMouse - 8 )

    end )
    header:Droppable( 'change_position_frame' )

    local main = vgui.Create( 'DPanel', frame )
    main:SetSize( frame:GetWide(), frame:GetTall() - header:GetTall() )
    main:SetPos( 0, header:GetTall() )
    main.Paint = function( self, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK )

    end

    return frame, main

end

local COLOR_PANEL = Color( 20, 20, 20, 210 )
function AMB.UI.GUI.Ambition.DrawConfirmPanel( xPos, yPos, sText, sAgree, sDisagree, fAgree, fDisagree )

    xPos = xPos or 0
    yPos = yPos or 0
    sText = sText or ''
    sAgree = sAgree..' [F1]' or 'Yes [F1]'
    sDisagree = sDisagree..' [F2]' or 'No [F2]'

    local main_size_w = AMB.Utility.GetTextSizeX( sText, '25 Ambition' )
    local agree_size_w = AMB.Utility.GetTextSizeX( sAgree, '20 Ambition' ) + 8
    local disagree_size_w = AMB.Utility.GetTextSizeX( sDisagree, '20 Ambition' ) + 8

    local main = vgui.Create( 'DPanel' )
    main:SetSize( main_size_w + 24, 70 )
    main:SetPos( xPos, yPos )
    main.Paint = function( self, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL )
        draw.SimpleTextOutlined( sText, '25 Ambition', w / 2, 4, C.AMB_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )

    end
    main:SetKeyboardInputEnabled( true )
    main:SetMouseInputEnabled( true )

    main.Think = function( self )

        if input.IsKeyDown( KEY_F1 ) then self:Remove() if fAgree then fAgree() end
        elseif input.IsKeyDown( KEY_F2 ) then self:Remove() if fDisagree then fDisagree() end
        end

    end

    local agree = vgui.Create( 'DButton', main )
    agree:SetSize( agree_size_w, 28 )
    agree:SetPos( 4, main:GetTall() - 28 - 4 )
    agree:SetText( '' )
    agree.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, C.ABS_BLACK )
        draw.SimpleText( sAgree, '20 Ambition', w / 2 - 1, h / 2, C.AMB_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    end
    agree.DoClick = function()

        if fAgree then fAgree() end
        main:Remove()

    end

    local dis = vgui.Create( 'DButton', main )
    dis:SetSize( disagree_size_w, 28 )
    dis:SetPos( main:GetWide() - disagree_size_w - 4, main:GetTall() - 28 - 4 )
    dis:SetText( '' )
    dis.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, C.ABS_BLACK )
        draw.SimpleText( sDisagree, '20 Ambition', w / 2 - 1, h / 2, C.AMB_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )

    end
    dis.DoClick = function()

        if fDisagree then fDisagree() end
        main:Remove()

    end

    return main

end