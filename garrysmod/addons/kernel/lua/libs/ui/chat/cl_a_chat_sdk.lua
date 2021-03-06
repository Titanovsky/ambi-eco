AMB.UI = AMB.UI or {}
AMB.UI.Chat = AMB.UI.Chat or {}
AMB.UI.Chat.log_chat = AMB.UI.Chat.log_chat or {}

local chat = chat
local unpack = unpack

function AMB.UI.Chat.SendMessage( sSound, ... )

    local tab = { ... }

    if sSound and ( sSound ~= '' ) and ( #sSound > 0 ) then AMB.UI.Sounds.PlaySound( sSound ) end

    chat.AddText( unpack( tab ) )

    AMB.UI.Chat.AddLogMessage( unpack( tab ) )

    return true

end

function AMB.UI.Chat.AddLogMessage( tInfo )

    AMB.UI.Chat.log_chat[ #AMB.UI.Chat.log_chat+1 ] = tInfo

end

function AMB.UI.Chat.GetLogs()

    return AMB.UI.Chat.log_chat

end


local function ReceiveSendMessage()

    local sound = net.ReadString()
    local tab = net.ReadTable()

    AMB.UI.Chat.SendMessage( sound, unpack( tab )  )

end
net.Receive( 'ambChatSendMessage', ReceiveSendMessage )