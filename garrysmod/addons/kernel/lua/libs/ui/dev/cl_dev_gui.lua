AMB.UI.Dev = AMB.UI.Dev or {}

local w = ScrW()
local h = ScrH()
local C = AMB.G.C
local COLOR_PANEL = Color( 48, 48, 48 )

function AMB.UI.Dev.OpenColorsMenu()

    local frame = AMB.UI.GUI.DrawFrame( nil, 800, 600, w/2-400, h/2-300, '', true, true, true, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBITION ) end )
    local panel = AMB.UI.GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall()-32, 0, 32, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, COLOR_PANEL ) end )
    local grid = AMB.UI.GUI.DrawGrid( panel, 129, 128, 8, 8, 6 )

    for name_color, color in SortedPairs( AMB.G.C ) do
        
        local panel = AMB.UI.GUI.DrawButton( nil, grid:GetColWide()-4, grid:GetRowHeight()-4, 0, 0, nil, nil, nil, function( self )

            SetClipboardText( 'AMB.G.C.'..name_color )
            frame:Remove()

        end, function( self, w, h )

            draw.SimpleTextOutlined( name_color, '24 Oswald Light', 0, 0, C.FLAT_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, C.ABS_BLACK )
            draw.RoundedBox( 4, 0, 24, w, h-24, color )
        
        end )
        panel.DoRightClick = function()

            SetClipboardText( 'Color( '..color.r..', '..color.g..', '..color.b..' )' )
            frame:Remove()

        end
        grid:AddItem( panel )

    end

end
concommand.Add( 'amb_dev_colors', AMB.UI.Dev.OpenColorsMenu )

function AMB.UI.Dev.OpenGreenTest( nFrame )

    if ( nFrame == 1 ) then

        local frame = AMB.UI.GUI.DrawFrame( nil, w/2.8, h/2.8, w/2-(w/2.8)/2, h/2-(h/2.8)/2, '', true, true, false, function( self, w, h ) draw.RoundedBox( 8, 0, 0, w, h, C.AMB_BLACK ) end )
        local header = AMB.UI.GUI.DrawPanel( frame, frame:GetWide(), 64, 0, 0, function( self, w, h ) draw.RoundedBoxEx( 8, 0, 0, w, h, C.AMB_ULTRA_GREEN, true, true ) end )
        local button = AMB.UI.GUI.DrawButton( frame, frame:GetWide()/2, frame:GetTall()/4, frame:GetWide()/2-frame:GetWide()/4, frame:GetTall()/2, 'Default', C.AMB_BLACK, 'CLICK NOW, BUTT!', function( self ) frame:Remove() end, function( self, w, h ) draw.RoundedBox( 32, 0, 0, w, h, C.AMB_ULTRA_GREEN ) end )

    end

end
concommand.Add( 'amb_dev_greentest', function( ePly, sCMD, tArgs ) 

    if ( #tArgs < 1 ) then tArgs[ 1 ] = 1 end

    AMB.UI.Dev.OpenGreenTest( tArgs[ 1 ] )

end )