local C = Ambi.General.Global.Colors
local Notify = Ambi.UI.Notify

local w = ScrW()
local h = ScrH()

local now_notify = {}

Notify.Add( 1, 'Offical Ambi Notify (Broken)', 'Ambi', function( tVars )
    now_notify[ #now_notify+1 ] = 'temp'
    local ID = #now_notify

    local time              = tVars.time
    local header            = tVars.header
    local description       = tVars.description
    local color_header      = tVars.color_header
    local sound             = tVars.sound

    --Ambi.UI.Notify.AddLogNotify( text )
end )