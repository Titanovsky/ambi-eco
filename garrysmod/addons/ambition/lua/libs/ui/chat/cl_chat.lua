AMB.UI.Chat = AMB.UI.Chat or {}

-- -------------------------------------------------------------------------------------
local A = AMB.Ambition
local chat, unpack, net = chat, unpack, net
-- -------------------------------------------------------------------------------------

function AMB.UI.Chat.Send( ... )
    local tab = { ... }

    if GetConVar( 'amb_chat_obscene_language' ):GetBool() then
        for i = 1, #tab do
            local value = tab[ i ]
            if not isstring( value ) then continue end

            local _tab = string.Explode( ' ', value )
            for j = 1, #_tab do
                local word = _tab[ j ]
                if string.FindObsceneWords( word ) then _tab[ j ] = string.ReplaceObsceneWords( word ) end
            end

            tab[ i ] = string.Implode( ' ', _tab )
        end
    end

    chat.AddText( unpack( tab ) )
    AMB.UI.Chat.AddLog( tab )
end
CreateClientConVar( 'amb_chat_obscene_language', 0 )

-- -------------------------------------------------------------------------------------
local logs = {}

function AMB.UI.Chat.AddLog( tInfo )
    logs[ #logs + 1 ] = tInfo
end

function AMB.UI.Chat.GetLogs()
    return logs
end

-- -------------------------------------------------------------------------------------

net.Receive( 'amb_ui_chat_send', function() 
    local tab = net.ReadTable()
    if not tab then return end

    AMB.UI.Chat.Send( unpack( tab )  )
end )