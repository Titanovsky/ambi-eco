AMB.UI = AMB.UI or {}
AMB.UI.Sounds = AMB.UI.Sounds or {}

local net_string = AMB.Network.AddString( 'AmbSoundPlay' )

function AMB.UI.Sounds.PlaySound( ePly, sName )

    net.Start( net_string )
        net.WriteString( sName )
    net.Send( ePly )

end

function AMB.UI.Sounds.PlaySoundAll( sName )

    net.Start( net_string )
        net.WriteString( sName )
    net.Broadcast()

end