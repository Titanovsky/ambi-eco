local C, GUI, Draw, UI, Gen = Ambi.Packages.Out( '@d, general' )
local W, H = ScrW(), ScrH()
local SIZE_HEADER = 36
local SIZE_EXAMPLE = 36
local COLOR_TEXT = Color( 68, 64, 60 )
local COLOR_BACKGROUND = Color( 255, 254, 253 )
local COLOR_TEXT_EXTENDED = Color( 246, 221, 251)

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function OpenFontsMenu()
    local frame = GUI.DrawFrame( nil, W / 1.1, H / 1.1, 0, 0, '', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI ) end )
    frame:Center()
    local panel = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI_BLACK ) end )

    local i = 0
    for v, tab in SortedPairs( UI.GetFontTypes() ) do
        if ( tab.category ~= 'Ambi' ) then continue end

        i = i + 1
        local j = i
        local font = GUI.DrawButton( nil, panel:GetWide(), 46, 0, ( 46 ) * ( i - 1 ), nil, nil, nil, function( self )
            chat.AddText( v )
            SetClipboardText( v )

            frame:Remove()
        end, function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, self.color )

            Draw.SimpleText( 4, 4, j..'. '..v, UI.SafeFont( SIZE_HEADER..' '..v ), C.ABS_WHITE, 'top-left' )
            Draw.SimpleText( w - 16, h / 2, 'Hello, World! Привет Деда?', UI.SafeFont( SIZE_EXAMPLE..' '..v ), C.ABS_WHITE, 'center-right' )
        end )
        font.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        font:SetTooltip( v )
        panel:AddItem( font )

        GUI.OnCursor( font, function()
            font.color = Color( 0, 0, 0, 130 )
        end, function() 
            font.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        end )
    end

    for v, tab in SortedPairs( UI.GetFontTypes() ) do
        if ( tab.category ~= 'Ambi Extended' ) then continue end

        i = i + 1
        local j = i
        local font = GUI.DrawButton( nil, panel:GetWide(), 46, 0, ( 46 ) * ( i - 1 ), nil, nil, nil, function( self )
            chat.AddText( v )
            SetClipboardText( v )

            frame:Remove()
        end, function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, self.color )

            Draw.SimpleText( 4, 4, j..'. '..v, UI.SafeFont( SIZE_HEADER..' '..v ), COLOR_TEXT_EXTENDED, 'top-left' )
            Draw.SimpleText( w - 16, h / 2, 'Hello, World! Привет Деда?', UI.SafeFont( SIZE_EXAMPLE..' '..v ), COLOR_TEXT_EXTENDED, 'center-right' )
        end )
        font.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        font:SetTooltip( v )
        panel:AddItem( font )

        GUI.OnCursor( font, function()
            font.color = Color( 0, 0, 0, 130 )
        end, function() 
            font.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        end )
    end
end
Gen.AddConsoleCommand( 'dev_fonts', OpenFontsMenu )