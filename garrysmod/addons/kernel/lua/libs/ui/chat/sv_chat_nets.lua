AMB.UI = AMB.UI or {}
AMB.UI.Chat = AMB.UI.Chat or {}

local net_string = AMB.Network.AddString( 'AmbChatSendMessage' )

function AMB.UI.Chat.SendMessage( ePly, sSound, ... )

    local tab = { ... }

    if not sSound then sSound = '' end

    net.Start( net_string )
        net.WriteString( sSound )
        net.WriteTable( tab )
    net.Send( ePly )

end

function AMB.UI.Chat.SendMessageAll( sSound, ... )

    local tab = { ... }

    if not sSound then sSound = '' end

    net.Start( net_string )
        net.WriteString( sSound )
        net.WriteTable( tab )
    net.Broadcast()

end