AMB.UI = AMB.UI or {} -- on server!
AMB.UI.Chat = AMB.UI.Chat or {}

-- -------------------------------------------------------------------------------------
local Network = AMB.Ambition.Network
local IsValid, net, surface, FindMetaTable, unpack = IsValid, net, surface, FindMetaTable, unpack
-- -------------------------------------------------------------------------------------
local CHAT_NET_STRING = Network.AddString( 'amb_ui_chat_send' )

function AMB.UI.Chat.Send( ePly, ... )
    if not IsValid( ePly ) or not ePly:IsPlayer() then return end
    local tab = { ... }

    net.Start( CHAT_NET_STRING )
        net.WriteTable( tab )
    net.Send( ePly )
end

function AMB.UI.Chat.SendLocal( vPos, nRadius, ... )
    local tab = { ... }
    local entities = ents.FindInSphere( vPos or Vector( 0, 0, 0 ), nRadius or 0 )

    for i = 1, #entities do
        local ply = entities[ i ]
        if ply:IsPlayer() then
            net.Start( CHAT_NET_STRING )
                net.WriteTable( tab )
            net.Send( ply )
        end
    end
end

function AMB.UI.Chat.SendFiler( fFilter, ... )
    if not fFilter then return end

    local tab = { ... }
    local players = player.GetHumans()

    for i = 1, #players do
        local ply = players[ i ]
        if fFilter( ply ) then
            net.Start( CHAT_NET_STRING )
                net.WriteTable( tab )
            net.Send( ply )
        end
    end
end

function AMB.UI.Chat.SendAll( ... )
    local tab = { ... }

    net.Start( CHAT_NET_STRING )
        net.WriteTable( tab )
    net.Broadcast()
end

-- -------------------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:ChatSend( ... )
    local tab = { ... }
    
    AMB.UI.Chat.Send( self, unpack( tab ) )
end