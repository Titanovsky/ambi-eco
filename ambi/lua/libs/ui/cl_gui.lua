Ambi.UI.GUI = Ambi.UI.GUI or {}

local C, Gen, UT, Draw = Ambi.General.Global.Colors, Ambi.General, Ambi.General.Utility, Ambi.UI.Draw

local w, h = ScrW(), ScrH()
local vgui, draw, surface, IsColor, ValidPanel = vgui, draw, surface, IsColor, ValidPanel

function Ambi.UI.GUI.Draw( sVGUIType, vguiParent )
    return vgui.Create( sVGUIType or 'DPanel', vguiParent )
end

function Ambi.UI.GUI.DrawFrame( vguiParent, wSize, hSize, xPos, yPos, sTitle, bMakePopup, bDraggable, bShowBtns, fPaint )
    local frame = vgui.Create( 'DFrame', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetTitle( sTitle or '' )
    frame:SetDraggable( bDraggable or false )
    frame:ShowCloseButton( bShowBtns or false )
    if bMakePopup or ( bMakePopup == nil ) then frame:MakePopup() end
    if fPaint then frame.Paint = fPaint end

    return frame
end

function Ambi.UI.GUI.DrawPanel( vguiParent, wSize, hSize, xPos, yPos, fPaint )
    local frame = vgui.Create( 'DPanel', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    if fPaint then frame.Paint = fPaint end

    return frame
end

function Ambi.UI.GUI.DrawButton( vguiParent, wSize, hSize, xPos, yPos, sFont, cColorText, sText, fClick, fPaint )
    local frame = vgui.Create( 'DButton', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetFont( sFont or 'Default' )
    frame:SetTextColor( cColorText or C.ABS_BLACK )
    frame:SetText( sText or '' )
    if fPaint then frame.Paint = fPaint end
    if fClick then frame.DoClick = fClick end

    return frame
end

function Ambi.UI.GUI.DrawImage( vguiParent, wSize, hSize, xPos, yPos, matImage, cColorImg )
    local frame = vgui.Create( 'DPanel', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )

    local color_r, color_g, color_b, color_a = UT.UnpackColor( cColorImg or C.ABS_WHITE )
    frame.Paint = function( self, w, h )
        Draw.Material( w, h, 0, 0, matImage, color_r, color_g, color_b, color_a )
    end 

    return frame
end

function Ambi.UI.GUI.DrawGrid( vguiParent, nWideCols, nRowHeight, xPos, yPos, nCols )
    local frame = vgui.Create( 'DGrid', vguiParent )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetCols( nCols or 1 )
    frame:SetColWide( nWideCols or 0 )
    frame:SetRowHeight( nRowHeight or 0 )

    return frame
end

function Ambi.UI.GUI.DrawScrollPanel( vguiParent, wSize, hSize, xPos, yPos, fPaint )
    local frame = vgui.Create( 'DScrollPanel', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    if fPaint then frame.Paint = fPaint end

    return frame
end

function Ambi.UI.GUI.DrawScrollBar( vguiScrollPanel, fPaint )
    if not ValidPanel( vguiScrollPanel ) then Gen.Error( 'UI.GUI', 'DrawScrollBar: selected unvalid vguiScrollPanel' ) return end
    local sbar = vguiScrollPanel:GetVBar()
    sbar.Paint = fPaint

    return sbar
end

function Ambi.UI.GUI.DrawScrollBarGrip( vguiScrollPanel, fPaint )
    if not ValidPanel( vguiScrollPanel ) then Gen.Error( 'UI.GUI', 'DrawScrollBarGrip: selected unvalid vguiScrollPanel' ) return end
    local sbar = vguiScrollPanel:GetVBar()
    sbar.btnGrip.Paint = fPaint

    return sbar.btnGrip

end

function Ambi.UI.GUI.DrawScrollBarButtonUp( vguiScrollPanel, fPaint )
    if not ValidPanel( vguiScrollPanel ) then Gen.Error( 'UI.GUI', 'DrawScrollBarButtonUp: selected unvalid vguiScrollPanel' ) return end
    local sbar = vguiScrollPanel:GetVBar()
    sbar.btnUp.Paint = fPaint

    return sbar.btnUp
end

function Ambi.UI.GUI.DrawScrollBarButtonDown( vguiScrollPanel, fPaint )
    if not ValidPanel( vguiScrollPanel ) then Gen.Error( 'UI.GUI', 'DrawScrollBarButtonDown: selected unvalid vguiScrollPanel' ) return end
    local sbar = vguiScrollPanel:GetVBar()
    sbar.btnDown.Paint = fPaint

    return sbar.btnDown
end

function Ambi.UI.GUI.DrawHorizontalScrollPanel( vguiParent, wSize, hSize, xPos, yPos, nOverLap, fPaint )
    local frame = vgui.Create( 'DHorizontalScroller', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetOverlap( nOverLap or 0 )
    if fPaint then frame.Paint = fPaint end

    return frame
end

function Ambi.UI.GUI.DrawAvatar( vguiParent, wSize, hSize, xPos, yPos, nSize, pModel )
    local frame = vgui.Create( 'AvatarImage', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetPlayer( pModel or LocalPlayer(), nSize or 0 )

    return frame
end

function Ambi.UI.GUI.DrawCheckBox( vguiParent, xPos, yPos, sFont, cColorText, sText, bValue, sConVar, bSizeToContent )
    local frame = vgui.Create( 'DCheckBoxLabel', vguiParent )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetFont( sFont or 'Default' )
    frame:SetTextColor( cColorText or C.ABS_WHITE )
    frame:SetText( sText or '' )
    frame:SetValue( bValue or false )
    if sConVar then frame:SetConVar( sConVar ) end
    if bSizeToContent then frame:SizeToContents() end

    return frame
end

function Ambi.UI.GUI.DrawComboBox( vguiParent, wSize, hSize, xPos, yPos, sFont, sValue, fOnSelect )
    local frame = vgui.Create( 'DComboBox', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetFont( sFont or 'Default' )
    frame:SetValue( sValue or '' )
    if fOnSelect then frame.OnSelect = fOnSelect end

    return frame
end

function Ambi.UI.GUI.DrawTextEntry( vguiParent, wSize, hSize, xPos, yPos, sFont, cColorText, sValue, cColorTextPlaceholder, sPlaceholder, bMultiline, bOnlyNumber )
    local frame = vgui.Create( 'DTextEntry', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetFont( sFont or 'Default' )
    frame:SetTextColor( cColorText or C.ABS_BLACK )
    frame:SetValue( sValue or '' )
    frame:SetPlaceholderColor( cColorTextPlaceholder or C.ABS_WHITE )
    frame:SetPlaceholderText( sPlaceholder or '' )
    frame:SetMultiline( bMultiline or false )
    frame:SetNumeric( bOnlyNumber or false )
    return frame
end

function Ambi.UI.GUI.DrawColorMixer( vguiParent, wSize, hSize, xPos, yPos, cDefaultColor, bSetPalette, bSetWangs, bSetAlphaBar )
    local frame = vgui.Create( 'DColorMixer', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetPalette( bSetPalette )
    frame:SetWangs( bSetWangs )
    frame:SetAlphaBar( bSetAlphaBar )
    frame:SetColor( cDefaultColor or C.ABS_BLACK )

    return frame
end

function Ambi.UI.GUI.DrawModel( vguiParent, wSize, hSize, xPos, yPos, sModelPath, nSkin, sBodygroup )
    local frame = vgui.Create( 'ModelImage', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetModel( sModelPath or '', nSkin or 0, sBodygroup or '' )

    return frame
end

function Ambi.UI.GUI.DrawModel3D( vguiParent, wSize, hSize, xPos, yPos, sModelPath )
    local frame = vgui.Create( 'DModelPanel', vguiParent )
    frame:SetSize( wSize or 0, hSize or 0 )
    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetModel( sModelPath or '' )

    return frame
end

-- Options --------------------------------------------------------------------------------------
function Ambi.UI.GUI.OnCursor( vguiPanel, fOnCursorEntered, fOnCursorExited )
    if not ValidPanel( vguiPanel ) then Gen.Error( 'UI.GUI', 'OnCursor: selected unvalid vguiPanel' ) return end

    vguiPanel.OnCursorEntered = fOnCursorEntered or function() end
    vguiPanel.OnCursorExited = fOnCursorExited or function() end

    return vguiPanel
end

function Ambi.UI.GUI.OnClick( vguiPanel, fLeftClick, fRightClick, fMiddleClick )
    if not ValidPanel( vguiPanel ) then Gen.Error( 'UI.GUI', 'OnClick: selected unvalid vguiPanel' ) return end

    local click_l, click_r, click_m = fLeftClick or function() end, fRightClick or function() end, fMiddleClick or function() end
    vguiPanel.OnMouseReleased = function( self, nKey )
        if ( nKey == 107 ) then click_l( self ) end
        if ( nKey == 108 ) then click_r( self ) end
        if ( nKey == 109 ) then click_m( self ) end
    end

    return vguiPanel
end

function Ambi.UI.GUI.OnRemove( vguiPanel, fOnRemove )
    if not ValidPanel( vguiPanel ) then Gen.Error( 'UI.GUI', 'OnRemove: selected unvalid vguiPanel' ) return end

    vguiPanel.OnRemove = fOnRemove or function() end

    return vguiPanel
end