AMB.UI.Notify = AMB.UI.Notify or {}

local C = AMB.Ambition.Global.Colors

local logs = {}
local notifies = {}

function AMB.UI.Notify.Add( nID, sName, sAuthor, fDraw )
    notifies[ nID ] = {
        name = sName,
        author = sAuthor,
        Draw = fDraw
    }
end

function AMB.UI.Notify.Draw( nID, tVars )
    local notify = notifies[ nID ]
    if not notify then return end

    notify.Draw( tVars or {} )
end

function AMB.UI.Notify.GetNotifies()
    return notifies
end

function AMB.UI.Notify.AddLog( sText, sColor )
    logs[ #logs + 1 ] = { time = os.date( '%X', os.time() ), text = sText or '', color = sColor or C.ABS_WHITE }
end

function AMB.UI.Notify.GetLogs()
    return logs
end

net.Receive( 'amb_ui_notify_draw', function()
    local id = net.ReadUInt( 6 ) or 1
    local tab = net.ReadTable() or {}

    AMB.UI.Notify.Draw( id, tab )
end )

-- Compability ------------------------------------------
AMB.UI.Notify = AMB.UI.Notify or {}
AMB.UI.Notify.RegisterNotify = AMB.UI.Notify.Add
AMB.UI.Notify.DrawNotify = AMB.UI.Notify.Draw
AMB.UI.Notify.AddLogNotify = AMB.UI.Notify.AddLog
AMB.UI.Notify.GetTable = AMB.UI.Notify.GetNotifies