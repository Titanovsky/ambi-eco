AMB.UI = AMB.UI or {}
AMB.UI.GUI = AMB.UI.GUI or {}

local w = ScrW()
local h = ScrH()
local C = AMB.G.C

local vgui = vgui
local draw = draw
local surface = surface

function AMB.UI.GUI.Draw( vguiPanel, vguiParent )

    local frame = vgui.Create( vguiPanel, vguiParent )

    return frame

end

function AMB.UI.GUI.DrawFrame( vguiParent, wSize, hSize, xPos, yPos, sTitle, bMakePopup, bDraggable, bShowBtns, fPaint )

    wSize       = wSize or 24
    hSize       = hSize or 24
    xPos        = xPos or 0
    yPos        = yPos or 0
    sTitle      = sTitle or ''
    bMakePopup  = bMakePopup or true
    bDraggable  = bDraggable or false
    bShowBtns   = bShowBtns or false

    local frame = vgui.Create( 'DFrame', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    if bMakePopup then frame:MakePopup() end
    frame:SetTitle( sTitle )
    frame:SetDraggable( bDraggable )
    frame:ShowCloseButton( bShowBtns )

    if fPaint then frame.Paint = fPaint end

    return frame

end

function AMB.UI.GUI.DrawPanel( vguiParent, wSize, hSize, xPos, yPos, fPaint )

    wSize   = wSize or 24
    hSize   = hSize or 24
    xPos    = xPos or 0
    yPos    = yPos or 0

    local frame = vgui.Create( 'DPanel', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )

    if fPaint then frame.Paint = fPaint end

    return frame

end

function AMB.UI.GUI.DrawButton( vguiParent, wSize, hSize, xPos, yPos, sFont, cColorText, sText, fClick, fPaint )

    wSize       = wSize or 24
    hSize       = hSize or 24
    xPos        = xPos or 0
    yPos        = yPos or 0
    sFont       = sFont or 'Default'
    cColorText  = cColorText or AMB.G.C.BLACK
    sText       = sText or ''

    local frame = vgui.Create( 'DButton', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame:SetFont( sFont )
    frame:SetTextColor( cColorText )
    frame:SetText( sText )

    if fPaint then frame.Paint = fPaint end
    if fClick then frame.DoClick = fClick end

    return frame

end

function AMB.UI.GUI.DrawText( vguiParent, xPos, yPos, sFont, cColorText, sText, bSizeToContent )

    local frame = vgui.Create( 'DLabel', vguiParent )

    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetFont( sFont or 'Default' )
    frame:SetTextColor( cColorText or AMB.G.C.ABS_WHITE )
    frame:SetText( sText or '' )
    if bSizeToContent then frame:SizeToContents() end

    return frame

end

function AMB.UI.GUI.DrawImage( vguiParent, wSize, hSize, xPos, yPos, matImage, cColorImg )

    wSize   = wSize or 16
    hSize   = hSize or 16
    xPos    = xPos or 0
    yPos    = yPos or 0

    local frame = vgui.Create( 'DPanel', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    local x, y = frame:GetPos()

    frame.Paint = function( self, w, h )

        surface.SetMaterial( matImage )
	    surface.SetDrawColor( cColorImg )
	    surface.DrawTexturedRect( 0, 0, w, h )

    end 

    return frame

end

function AMB.UI.GUI.DrawGrid( vguiParent, nWideCols, nRowHeight, xPos, yPos, nCols )

    local frame = vgui.Create( 'DGrid', vguiParent )

    frame:SetPos( xPos or 0, yPos or 0 )
    frame:SetCols( nCols or 1 )
    frame:SetColWide( nWideCols or 4 )
    frame:SetRowHeight( nRowHeight or 4 )

    return frame

end

function AMB.UI.GUI.DrawScrollPanel( vguiParent, wSize, hSize, xPos, yPos, fPaint )

    wSize   = wSize or 24
    hSize   = hSize or 24
    xPos    = xPos or 0
    yPos    = yPos or 0

    local frame = vgui.Create( 'DScrollPanel', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )

    if fPaint then frame.Paint = fPaint end

    return frame

end

function AMB.UI.GUI.DrawScrollBar( vguiScrollPanel, fPaint )

    local sbar = vguiScrollPanel:GetVBar()

    sbar.Paint = fPaint

    return sbar

end

function AMB.UI.GUI.DrawScrollBarGrip( vguiScrollPanel, fPaint )

    local sbar = vguiScrollPanel:GetVBar()

    sbar.btnGrip.Paint = fPaint

    return sbar.btnGrip

end

function AMB.UI.GUI.DrawScrollBarButtonUp( vguiScrollPanel, fPaint )

    local sbar = vguiScrollPanel:GetVBar()

    sbar.btnUp.Paint = fPaint

    return sbar.btnUp

end

function AMB.UI.GUI.DrawScrollBarButtonDown( vguiScrollPanel, fPaint )

    local sbar = vguiScrollPanel:GetVBar()

    sbar.btnDown.Paint = fPaint

    return sbar.btnDown

end

function AMB.UI.GUI.DrawAvatar( vguiParent, wSize, hSize, xPos, yPos, pModel, nSize )

    wSize   = wSize or 24
    hSize   = hSize or 24
    xPos    = xPos or 0
    yPos    = yPos or 0
    pModel  = pModel or LocalPlayer()
    nSize   = nSize or 32

    local frame = vgui.Create( 'AvatarImage', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame:SetPlayer( pModel, nSize )

    return frame

end

function AMB.UI.GUI.DrawCheckBox( vguiParent, xPos, yPos, sFont, cColorText, sText, bValue, sConVar, bSizeToContent )

    wSize       = wSize or 24
    hSize       = hSize or 24
    xPos        = xPos or 0
    yPos        = yPos or 0
    sFont       = sFont or 'Default'
    cColorText  = cColorText or AMB.G.C.WHITE
    sText       = sText or ''
    bValue      = bValue or false

    local frame = vgui.Create( 'DCheckBoxLabel', vguiParent )

    --frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame:SetFont( sFont )
    frame:SetTextColor( cColorText )
    frame:SetText( sText )
    frame:SetValue( bValue )
    if sConVar then frame:SetConVar( sConVar ) end
    if bSizeToContent then frame:SizeToContents() end

    return frame

end

function AMB.UI.GUI.DrawComboBox( vguiParent, wSize, hSize, xPos, yPos, sFont, sValue, fOnSelect )

    wSize   = wSize or 24
    hSize   = hSize or 24
    xPos    = xPos or 0
    yPos    = yPos or 0
    sFont   = sFont or '14 Ambition'
    sValue  = sValue or ''

    local frame = vgui.Create( 'DComboBox', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame:SetFont( sFont )
    frame:SetValue( sValue )

    if fOnSelect then frame.OnSelect = fOnSelect end

    return frame

end

function AMB.UI.GUI.DrawTextEntry( vguiParent, wSize, hSize, xPos, yPos, sFont, cColorText, sValue, cColorTextPlaceholder, sPlaceholder, bMultiline, bOnlyNumber )

    wSize                   = wSize or 24
    hSize                   = hSize or 24
    xPos                    = xPos or 0
    yPos                    = yPos or 0
    sFont                   = sFont or 'DermaDefault'
    sValue                  = sValue or ''
    cColorText              = cColorText or C.ABS_BLACK
    bMultiline              = bMultiline or false
    bOnlyNumber             = bOnlyNumber or false
    sPlaceholder            = sPlaceholder or 'Вводить здесь :)'
    cColorTextPlaceholder   = cColorTextPlaceholder or C.AMB_GRAY

    local frame = vgui.Create( 'DTextEntry', vguiParent )

    frame:SetSize( wSize, hSize )
    frame:SetPos( xPos, yPos )
    frame:SetFont( sFont )
    frame:SetTextColor( cColorText )
    frame:SetValue( sValue )
    frame:SetPlaceholderColor( cColorTextPlaceholder )
    frame:SetPlaceholderText( sPlaceholder )
    frame:SetMultiline( bMultiline )
    frame:SetNumeric( bOnlyNumber )

    if fPaint then frame.Paint = fPaint end

    return frame

end

function AMB.UI.GUI.OnCursorButton( vguiButton, fOnCursorEntered, fOnCursorExited )

    vguiButton.OnCursorEntered = fOnCursorEntered
    vguiButton.OnCursorExited = fOnCursorExited

    return vguiButton

end
