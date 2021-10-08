Ambi.UI.Sound = Ambi.UI.Sound or {}

local Network = Ambi.General.Network
local net = net
local net_string = Network.AddString( 'ambi_ui_sound_player' )

function Ambi.UI.Sound.Play( ePly, sName )
    if not sName then return end

    net.Start( net_string )
        net.WriteString( sName )
    net.Send( ePly )
end

function Ambi.UI.Sound.PlayAll( sName )
    if not sName then return end

    net.Start( net_string )
        net.WriteString( sName )
    net.Broadcast()
end

-- Player -----------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:PlaySound( sName )
    Ambi.UI.Sound.Play( self, sName )
end

function PLAYER:SoundSend( sName )
    Ambi.UI.Sound.Play( self, sName )
end