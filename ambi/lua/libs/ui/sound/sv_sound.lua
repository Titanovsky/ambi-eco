Ambi.UI.Sound = Ambi.UI.Sound or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local Network = Ambi.General.Network
local net = net
local SOUND_NET_STRING = Network.AddString( 'ambi_ui_sound_player' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Sound.Play( ePly, sName )
    if not sName then return end

    net.Start( SOUND_NET_STRING )
        net.WriteString( sName )
    net.Send( ePly )
end

function Ambi.UI.Sound.PlayAll( sName )
    if not sName then return end

    net.Start( SOUND_NET_STRING )
        net.WriteString( sName )
    net.Broadcast()
end

function Ambi.UI.Sound.PlayInRadius( sName, vPos, nRadius )
    local entities = ents.FindInSphere( vPos or Vector( 0, 0, 0 ), nRadius or 0 )

    for i = 1, #entities do
        local ply = entities[ i ]
        if ply:IsPlayer() then
            net.Start( SOUND_NET_STRING )
                net.WriteString( sName )
            net.Send( ply )
        end
    end
end

function Ambi.UI.Sound.PlayFilter( sName, fFilter )
    if not fFilter then return end

    local players = player.GetAll()
    for i = 1, #players do
        local ply = players[ i ]
        if fFilter( ply ) then
            net.Start( SOUND_NET_STRING )
                net.WriteString( sName )
            net.Send( ply )
        end
    end
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:PlaySound( sName )
    Ambi.UI.Sound.Play( self, sName )
end

function PLAYER:SoundSend( sName )
    Ambi.UI.Sound.Play( self, sName )
end