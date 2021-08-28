AMB.UI.Sound = AMB.UI.Sound or {}

local Network = AMB.Ambition.Network
local net = net
local net_string = Network.AddString( 'amb_ui_sound_player' )

function AMB.UI.Sound.Play( ePly, sName )
    if not sName then return end

    net.Start( net_string )
        net.WriteString( sName )
    net.Send( ePly )
end

function AMB.UI.Sound.PlayAll( sName )
    if not sName then return end

    net.Start( net_string )
        net.WriteString( sName )
    net.Broadcast()
end

-- Player -----------------------------------------------
local Player = FindMetaTable( 'Player' )

function Player:PlaySound( sName )
    AMB.UI.Sound.Play( self, sName )
end

function Player:SoundSend( sName )
    AMB.UI.Sound.Play( self, sName )
end

-- Compatibility ----------------------------------------
AMB.UI.Sounds = AMB.UI.Sound
AMB.UI.Sounds.PlaySoundAll = AMB.UI.Sound.PlayAll
AMB.UI.Sounds.PlaySound = AMB.UI.Sound.Play