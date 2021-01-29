AMB.UI.Notify = AMB.UI.Notify or {}

local w = ScrW()
local h = ScrH()
local C = AMB.G.C

local now_notify = {}

AMB.UI.Notify.RegisterNotify( 1, 'Ambition Notify', 'A M B I T I O N', function( tVars )

    now_notify[ #now_notify+1 ] = 'temp'
    local ID = #now_notify

    local time              = tVars.time
    local header            = tVars.header
    local description       = tVars.description
    local color_header      = tVars.color_header
    local sound             = tVars.sound

    --AMB.UI.Notify.AddLogNotify( text )

end )