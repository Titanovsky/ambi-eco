AMB.UI = AMB.UI or {}
AMB.UI.Notify = AMB.UI.Notify or {}

local net_string = AMB.Network.AddString( 'AmbNotifySend' )

function AMB.UI.Notify.DrawNotify( ePly, nID, tVars )

    net.Start( net_string )
        net.WriteUInt( nID, 12 )
        net.WriteTable( tVars )
    net.Send( ePly )

end