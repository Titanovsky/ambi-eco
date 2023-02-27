Ambi.UI.Notify = Ambi.UI.Notify or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors

local logs = {}
local notifies = {} --! DON'T RESAVE THIS FILE, IF THE SERVER WORKS

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Notify.Add( nID, sName, sAuthor, fDraw, sModify )
    notifies[ nID ] = {
        name = sName,
        author = sAuthor,
        modifications = sModify,
        Draw = fDraw
    }
end

function Ambi.UI.Notify.AddSimpleInterface( nID, ... )
    local keys = { ... }

    notifies[ nID ].simple_draw_keys = keys
end

function Ambi.UI.Notify.Draw( nID, tVars )
    if not tVars then return end

    local notify = notifies[ nID ]
    if not notify then return end

    notify.Draw( tVars or {} )
end

function Ambi.UI.Notify.SimpleDraw( nID, ... )
    local values = { ... }

    local notify = notifies[ nID ]
    if not notify then return end
    if not notify.simple_draw_keys then return end

    local variables = {}
    for i = 1, #notify.simple_draw_keys do
        if not values[ i ] then break end
        variables[ notify.simple_draw_keys[ i ] ] = values[ i ]
    end

    Ambi.UI.Notify.Draw( nID, variables )
end

function Ambi.UI.Notify.GetNotifies()
    return notifies
end

function Ambi.UI.Notify.AddLog( sText, sColor )
    logs[ #logs + 1 ] = { time = os.date( '%X', os.time() ), text = sText or '', color = sColor or C.ABS_WHITE }
end

function Ambi.UI.Notify.GetLogs()
    return logs
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_ui_notify_draw', function()
    local id = net.ReadUInt( 16 )
    local tab = net.ReadTable()

    Ambi.UI.Notify.Draw( id, tab )
end )

net.Receive( 'ambi_ui_notify_simple_draw', function()
    local id = net.ReadUInt( 16 )
    if not notifies[ id ] then return end
    if not notifies[ id ].simple_draw_keys then return end

    local values = net.ReadTable()

    Ambi.UI.Notify.SimpleDraw( id, unpack( values ) )
end )