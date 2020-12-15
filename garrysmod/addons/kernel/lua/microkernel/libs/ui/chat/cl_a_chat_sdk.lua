AMB.UI = AMB.UI or {}
AMB.UI.Chat = AMB.UI.Chat or {}
AMB.UI.Chat.table = AMB.UI.Chat.table or {}
AMB.UI.Chat.log_chat = AMB.UI.Chat.log_chat or {}

local chat = chat
local unpack = unpack

function AMB.UI.Chat.GetTable()

    return AMB.UI.Chat.table

end

function AMB.UI.Chat.PrintTable()

    PrintTable( AMB.UI.Chat.table )

end

function AMB.UI.Chat.AddLogMessage( tab )

    AMB.UI.Chat.log_chat[ #AMB.UI.Chat.log_chat+1 ] = tab

end

function AMB.UI.Chat.SendMessage( sSound, ... )

    local tab = { ... }

    if sSound and ( sSound ~= '' ) then AMB.UI.Sounds.PlaySound( sSound ) end

    chat.AddText( unpack( tab ) )

    AMB.UI.Chat.AddLogMessage( unpack( tab ) )

    return true

end

local function ReceiveSendMessage()

    local sound = net.ReadString()
    local tab = net.ReadTable()

    AMB.UI.Chat.SendMessage( sound, unpack( tab )  )

end
net.Receive( 'ambChatSendMessage', ReceiveSendMessage )