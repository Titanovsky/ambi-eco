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