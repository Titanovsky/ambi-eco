local C, GUI, Gen = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.General
local W, H = ScrW(), ScrH()

function Ambi.Base.OpenColorsMenu()
    local frame = GUI.DrawFrame( nil, 800, 600, W / 2 - 400, H / 2 - 300, '', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI ) end )
    local panel = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI_BLACK ) end )
    local grid = GUI.DrawGrid( panel, 129, 128, 8, 8, 6 )

    for name, color in SortedPairs( C ) do
        local panel = GUI.DrawButton( nil, grid:GetColWide()-4, grid:GetRowHeight()-4, 0, 0, nil, nil, nil, function( self )
            local text = name
            chat.AddText( text )
            SetClipboardText( text )

            frame:Remove()
        end, function( self, w, h )
            draw.SimpleTextOutlined( name, '24 Oswald Light', 0, 0, C.FLAT_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
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
Gen.AddConsoleCommand( 'base_colors', Ambi.Base.OpenColorsMenu )

function AMB.Base.OpenFontsMenu()
    local frame = GUI.DrawFrame( nil, 800, 600, W / 2 - 400, H / 2 - 300, '', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI ) end )
    local panel = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBI_BLACK ) end )

    local i = 0
    for _, cat in SortedPairs( Ambi.UI.Font.fonts ) do
        for name, _ in SortedPairs( cat ) do
            i = i + 1
            local font = GUI.DrawButton( nil, panel:GetWide(), 32, 0, 36 * ( i - 1 ), nil, nil, nil, function( self )
                chat.AddText( C.ABS_WHITE, name )
                SetClipboardText( name )

                frame:Remove()
            end, function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, C.PANEL )
                draw.SimpleTextOutlined( name, '30 '..name, 4, h / 2, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
                draw.SimpleTextOutlined( 'Привет, Титан! Hi, Titan', '28 '..name, w - 16, h / 2, C.ABS_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
            end )
            panel:AddItem( font )
        end
    end
end
Gen.AddConsoleCommand( 'base_fonts', Ambi.Base.OpenFontsMenu )