Ambi.UI.Notify = Ambi.UI.Notify or {}

local C = Ambi.General.Global.Colors

local logs = {}
local notifies = {}

function Ambi.UI.Notify.Add( nID, sName, sAuthor, fDraw )
    notifies[ nID ] = {
        name = sName,
        author = sAuthor,
        Draw = fDraw
    }
end

function Ambi.UI.Notify.Draw( nID, tVars )
    local notify = notifies[ nID ]
    if not notify then return end

    notify.Draw( tVars or {} )
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

net.Receive( 'ambi_ui_notify_draw', function()
    local id = net.ReadUInt( 16 ) or 1
    local tab = net.ReadTable() or {}

    Ambi.UI.Notify.Draw( id, tab )
end )