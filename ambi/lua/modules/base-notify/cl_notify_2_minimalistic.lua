local C, GUI, Draw, UI, Notify = Ambi.Packages.Out( '@d, Notify' )
local W, H = ScrW(), ScrH()
local MAX_ID = 32
local COLOR_PANEL = Color( 38, 38, 38, 230 )
local ERROR_ICONS = { 1, 2, 3, 4, 5, 6 } -- the first six numbers are error icon.

local notifies = {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
local function GetID()
    for i = 1, MAX_ID do
        if not notifies[ i ] then return i end
    end

    return 1
end
-- ---------------------------------------------------------------------------------------------------------------------------------------
Notify.Add( 2, 'Minimalistic Notify', 'Ambi', function( tVars )
    local time = tVars.time or 4
    local text = tVars.text or ''
    local color = tVars.color or COLOR_PANEL -- main panel
    local color_text = tVars.color_text or C.WHITE
    local sound = tVars.sound or 'ButtonTU2'
    local font = tVars.font or '32 Ambi'
    font = UI.SafeFont( font )
    text = '• '..text
    local size = Draw.GetTextSizeX( font, text ) + 4

    local ID = GetID()
    notifies[ ID ] = true
    
    local name_timer = 'TimeNotify2Send'..ID..math.random(1,99999999) -- random, because local table notifies, when I test this moment, without random can be ruined

    local panel = GUI.DrawPanel( nil, size + 12, 32 + 6, W / 2 - size / 2, H - ( 38 + 4 ) * ID, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, color, 4 )

        Draw.SimpleText( w / 2, h / 2, text, font, color_text, 'center', 1, C.ABS_BLACK )
    end )

    surface.PlaySound( sound )

    timer.Create( name_timer, time, 1, function()
        if ValidPanel( panel ) then panel:Remove() end
        notifies[ ID ] = false
    end )
end, 'time, text, color_text, color, sound, font' )

Notify.AddSimpleInterface( 2, 'time', 'text', 'color_text', 'color', 'sound', 'font' )