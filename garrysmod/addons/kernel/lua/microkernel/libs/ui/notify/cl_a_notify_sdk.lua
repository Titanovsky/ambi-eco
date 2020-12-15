AMB.UI.Notify = AMB.UI.Notify or {}
AMB.UI.Notify.table = AMB.UI.Notify.table or {}
AMB.UI.Notify.log_notify = AMB.UI.Notify.log_notify or {}

function AMB.UI.Notify.RegisterNotify( nID, sName, sAuthor, fDraw )

    AMB.UI.Notify.table[ nID ] = {

        name = sName,
        author = sAuthor,
        draw = fDraw

    }

    return true

end

function AMB.UI.Notify.DrawNotify( nID, tVars )

    if AMB.UI.Notify.table[ nID ].draw( tVars ) then return true end

    return false

end

function AMB.UI.Notify.AddLogNotify( sText )

    AMB.UI.Notify.log_notify[ #AMB.UI.Notify.log_notify + 1 ] = { time = os.date( '%X', os.time() ), text = sText }

end

function AMB.UI.Notify.GetTable()

    return AMB.UI.Notify.table

end

function AMB.UI.Notify.PrintTable()

    PrintTable( AMB.UI.Notify.table )

end

function AMB.UI.Notify.PrintLogs()

    PrintTable( AMB.UI.Notify.log_notify )

end

net.Receive( 'ambNotifySend', function()

    local ID = net.ReadUInt( 12 )
    local tab = net.ReadTable()

    AMB.UI.Notify.DrawNotify( ID, tab )

end )
