local Gen = Ambi.General
local NetworkIDToString, AddNetworkString, IsValid, Color = util.NetworkIDToString, util.AddNetworkString, IsValid, Color
local Call = hook.Call
local Start, Send, ReadUInt, WriteUInt = net.Start, SERVER and net.Send or net.SendToServer, net.ReadUInt, net.WriteUInt
local PLAYER = FindMetaTable( 'Player' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:SetBlockNetMessages( bSet )
    if CLIENT then return end

    self.block_net_messages = bSet
end

function PLAYER:IsBlockNetMessages()
    return self.block_net_messages
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.General.Network.Incoming( nLen, ePly )
    if SERVER and ePly:IsBlockNetMessages() then return end

    local i = net.ReadHeader()
	local strName = util.NetworkIDToString( i )

	strName = strName:lower()
	
	local func = net.Receivers[ strName:lower() ]
	if ( func == nil ) then return end

	if ( Call( '[Ambi.General.Network.CanIncoming]', nil, ePly, strName, func, nLen ) == false ) then return end

	nLen = nLen - 16
	
	func( nLen, ePly )

    Call( 'IncomingNetMessage', nil, nLen, ePly, strName )
    Call( '[Ambi.General.Network.Incoming]', nil, nLen, ePly, strName )
end

function Ambi.General.Network.Receive( sNetString, fCallback )
    if ( sNetString == nil ) then Gen.Error( 'General.Network', 'Receive | sNetString == nil' ) return end
	if ( fCallback == nil ) then Gen.Error( 'General.Network', 'Receive | fCallback == nil' ) return end

    if ( Call( '[Ambi.General.Network.CanReceive]', nil, sNetString, fCallback ) == false ) then return end

    net.Receivers[ sNetString:lower() ] = fCallback

    Call( '[Ambi.General.Network.Receive]', nil, sNetString, fCallback )
end

net.Incoming = Ambi.General.Network.Incoming
net.Receive = Ambi.General.Network.Receive

Gen.Log( 'net.Incoming and net.Receive has replaced!' )