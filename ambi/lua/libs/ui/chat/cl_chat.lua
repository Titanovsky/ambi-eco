Ambi.UI.Chat = Ambi.UI.Chat or {}

-- -------------------------------------------------------------------------------------
local A = Ambi.General
local chat, unpack, net = chat, unpack, net
-- -------------------------------------------------------------------------------------

-- TODO: Сделать ассоциацию с Ambi.General.Language через #
-- TODO: Сделать возможность парсить цвет через одну строку с помощью ~red~ 

function Ambi.UI.Chat.Send( ... )
    local tab = { ... }

    if GetConVar( 'ambi_chat_obscene_language' ):GetBool() then
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
    Ambi.UI.Chat.AddLog( tab )
end
CreateClientConVar( 'ambi_chat_obscene_language', 0 )

-- -------------------------------------------------------------------------------------
local logs = {}

function Ambi.UI.Chat.AddLog( tInfo )
    logs[ #logs + 1 ] = tInfo
end

function Ambi.UI.Chat.GetLogs()
    return logs
end

-- -------------------------------------------------------------------------------------

net.Receive( 'ambi_ui_chat_send', function() 
    local tab = net.ReadTable()
    if not tab then return end

    Ambi.UI.Chat.Send( unpack( tab )  )
end )