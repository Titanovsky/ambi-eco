AMB.UI = AMB.UI or {}
AMB.UI.GUI = AMB.UI.GUI or {}
AMB.UI.GUI.GreenTest = AMB.UI.GUI.GreenTest or {}

local w = ScrW()
local h = ScrH()

local COLOR_GREEN = Color( 0, 255, 128 )
local COLOR_BLACK = Color( 51, 51, 51 )
local COLOR_WHITE = Color( 255, 255, 255 )
local TAC = TEXT_ALIGN_CENTER

local function DrawFrame( fw, fh, header )

    local frame = AMB.UI.GUI.DrawFrame( nil, w/2.8, h/2.8, 0, 0, '', true, true, false, function( self, w, h ) 

        draw.RoundedBox( 8, 0, 0, w, h, COLOR_BLACK )
        
    end )
    frame:Center()

    local header = AMB.UI.GUI.DrawPanel( frame, frame:GetWide(), 64, 0, 0, function( self, w, h ) 

        draw.RoundedBoxEx( 8, 0, 0, w, h, COLOR_GREEN, true, true )
        draw.SimpleText( string.upper( header ), '28 Ambition', w/2, h/2, COLOR_BLACK, TAC, TAC )

    end )

    return frame

end

function AMB.UI.GUI.GreenTest.DrawResults()

    local frame = DrawFrame( w/2.8, h/2.8, 'ИТОГИ' )

    local fw, fh = frame:GetWide(), frame:GetTall()
    local bw, bh = fw/1.4, fh/4.2
    local text = 'Поздравляем, Вы успешно сдали экзамен!'
    surface.SetFont( '20 Ambition' )
    local xtext, _ = surface.GetTextSize( text )

    AMB.UI.GUI.DrawText( frame, fw/2-xtext/2, fh/2-20, '20 Ambition', COLOR_WHITE, text, true )

    local button = AMB.UI.GUI.DrawButton( frame, bw, bh, fw/2-bw/2, fh-100, '28 Ambition', COLOR_BLACK, 'ПОЛУЧИТЬ ПРАВА', function( self ) 
    
        frame:Remove() 
        
    end, function( self, w, h )

        draw.RoundedBox( 32, 0, 0, w, h, COLOR_GREEN ) 
    
    end )

end