local C, GUI, Draw, UI, Lang, CL, Notify = Ambi.Packages.Out( '@d, Language, ContentLoader, Notify' )
local W, H = ScrW(), ScrH()
local MAX_ID = 32
local COLOR_PANEL = Color( 38, 38, 38 )
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
Notify.Add( 1, 'Ambi Notify', 'Ambi', function( tVars )
    local time = tVars.time or 4
    local text = tVars.text or ''
    local type = tVars.type or 1
    local color = tVars.color or COLOR_PANEL -- main panel
    local color_text = tVars.color_text or C.WHITE
    local color_icon = tVars.color_icon or C.AMBI_BLACK
    local color_icon_panel = tVars.color_icon_panel or C.AMBI -- small panel for icon
    local color_line = tVars.color_line or C.AMBI
    local sound = tVars.sound or 'ButtonTU2'
    local font = tVars.font or '26 Ambi'
    font = UI.SafeFont( font )
    local size = Draw.GetTextSizeX( font, text ) + 12

    if ERROR_ICONS[ type ] then 
        if not tVars.sound then sound = 'AmbiNotify1Error' end
        if not tVars.color_line then color_line = C.AMBI_RED end
        if not tVars.color_icon_panel then color_icon_panel = C.AMBI_RED end
        if not tVars.color_icon then color_icon = C.WHITE end
    end

    local ID = GetID()
    notifies[ ID ] = true
    local name_timer = 'TimeNotifySend'..ID
    local margin_line_x = 36

    local panel = GUI.DrawPanel( nil, size + 32 + 4, 32 + 6, W / 2 - size / 2, H - ( 38 + 4 ) * ID, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, color, 4 )
        Draw.Box( 36, h, 0, 0, color_icon_panel, 4, { true, false, true, false } )

        Draw.Material( 32, 32, 2, 3, CL.Material( 'notify1_'..type ), color_icon )
        Draw.SimpleText( 40, h / 2 - 2, text, font, color_text, 'center-left', 1, C.ABS_BLACK )

        -- Time
        local time_now = timer.TimeLeft( name_timer )
        if not time_now then self:Remove() return end -- can be call bug

        Draw.Box( ( w - margin_line_x ) * ( time_now / time ), 4, margin_line_x, h - 4, color_line ) -- this solution by divon

        -- my solution
        -- local temp = w / time
        -- local time_now = timer.TimeLeft( name_timer ) + 1
        -- Draw.Box( w - temp * ( time - time_now + 1 ), 2, 32, h - 2, C.WHITE )
    end )

    surface.PlaySound( sound )

    timer.Create( name_timer, time, 1, function()
        if ValidPanel( panel ) then panel:Remove() end
        notifies[ ID ] = false
    end )
end, 'type, time, text, color, color_icon, color_icon_panel, color_line, color_text, sound, font' )

Notify.AddSimpleInterface( 1, 'type', 'time', 'text', 'sound', 'color', 'color_icon', 'color_icon_panel', 'color_line', 'color_text', 'sound', 'font', 'material' )