local C, UI, GUI, Gen = Ambi.Packages.Out( 'colors, ui, gui, general' )
local W, H = ScrW(), ScrH()
local COLS = 8

-- --------------------------------------------------------------------------------------------------------------------------------------------
UI.AddFont( 'DevPanelColors', { font = 'Oswald Light', size = 38, weight = 100, extended = true } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function OpenColorsMenu()
    local frame = GUI.DrawFrame( nil, W / 1.1, H / 1.1, 0, 0, '', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI ) end )
    frame:Center()

    local panel = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI_BLACK ) end )
    local grid = GUI.DrawGrid( panel, ( panel:GetWide() - 16 * 2 ) / COLS, 128, 16, 8, COLS )

    for name, color in SortedPairs( C ) do
        local panel = GUI.DrawButton( grid, grid:GetColWide() - 4, grid:GetRowHeight()-4, 0, 0, nil, nil, nil, function( self )
            local text = name
            chat.AddText( text )
            SetClipboardText( text )

            frame:Remove()
        end, function( self, w, h )
            draw.SimpleTextOutlined( name, 'DevPanelColors', 0, -12, C.FLAT_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
            draw.RoundedBox( 4, 0, 24, w, h-24, color )
        end )
        panel.DoRightClick = function()
            local text = 'Color( '..color.r..', '..color.g..', '..color.b..' )'
            chat.AddText( text )
            SetClipboardText( text )
            
            frame:Remove()
        end
        grid:AddItem( panel )
    end
end
Gen.AddConsoleCommand( 'dev_colors', OpenColorsMenu )