AMB.Ambition.Network = AMB.Ambition.Network or {}
setmetatable( AMB.Ambition.Network, { __index = net } )

-- -------------------------------------------------------------------------------------
local NetworkIDToString, AddNetworkString, IsValid, Color = util.NetworkIDToString, util.AddNetworkString, IsValid, Color
local Call = hook.Call
local Start, Send, ReadUInt, WriteUInt = net.Start, SERVER and net.Send or net.SendToServer, net.ReadUInt, net.WriteUInt
-- -------------------------------------------------------------------------------------

AMB.Ambition.Network.strings = AMB.Ambition.Network.strings or {}

function net.AddString( sName, sDesc )
    if not sName then return end

    if SERVER then 
        AddNetworkString( sName ) 
        AMB.Ambition.Network.strings[ sName ] = sDesc or ''

        return sName
    end
end

function net.GetStrings()
    return AMB.Ambition.Network.strings
end

-- -------------------------------------------------------------------------------------

function net.Incoming( nLen, ePly )
    if SERVER and ( IsValid( ePly ) == false ) then return end

    local i = net.ReadHeader()
	local strName = util.NetworkIDToString( i )
	if ( strName == nil ) then return end
	
	local func = net.Receivers[ strName:lower() ]
	if ( func == nil ) then return end

	nLen = nLen - 16
	
	func( nLen, ePly )

    hook.Call( 'IncomingNetMessage', nil, nLen, ePly )
    hook.Call( '[AMB.Ambition.Network.Incoming]', nil, nLen, ePly )
end

function net.Receive( sNetString, fCallback )
    if ( sNetString == nil ) then return end

    net.Receivers[ sNetString:lower() ] = fCallback

    hook.Call( '[AMB.Ambition.Network.Receive]', nil, sNetString, fCallback )
end

function net.Ping( sMessage, anyClient )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/net.lua
	Start( sMessage )
	Send( anyClient )

    hook.Call( '[AMB.Ambition.Network.Ping]', nil, sMessage, anyClient )
end

-- -------------------------------------------------------------------------------------
-- by SuperiorServers
-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/net.lua

function net.WriteEntity( eObj )
	if IsValid( eObj ) then
		WriteUInt( eObj:EntIndex(), 13 )
	else
		WriteUInt( 0, 13 )
	end
end

function net.WriteByte( nByte )
	WriteUInt( nByte, 8 )
end

function net.WriteRGB( nRed, nGreen, nBlue )
	WriteUInt( nRed, 8 )
	WriteUInt( nGreen, 8 )
	WriteUInt( nBlue, 8 )
end

function net.WriteRGBA( nRed, nGreen, nBlue, nAlpha )
	WriteUInt( nRed, 8 )
	WriteUInt( nGreen, 8 )
	WriteUInt( nBlue, 8 )
	WriteUInt( nAlpha, 8 )
end
local WriteRGBA = net.WriteRGBA

function net.WriteColor( cColor )
	WriteRGBA( cColor.r, cColor.g, cColor.b, cColor.a )
end

function net.WriteNibble( nNibble )
	WriteUInt( nNibble, 4 )
end

function net.ReadShort()
	return ReadUInt( 16 )
end

function net.WriteShort( nShort )
	WriteUInt( nShort, 16 )
end

function net.WriteLong( nLong )
	WriteUInt( nLong, 32 )
end

function net.WritePlayer( ePly )
	if IsValid( ePly ) then
		WriteUInt( ePly:EntIndex(), 8 )
	else
		WriteUInt( 0, 8 )
	end
end

-- -------------------------------------------------------------------------------------
-- by SuperiorServers
-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/net.lua

function net.ReadNibble()
	return ReadUInt( 4 )
end

function net.ReadRGB()
	return ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 )
end

function net.ReadRGBA()
	return ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 )
end
local ReadRGBA = net.ReadRGBA

function net.ReadColor()
	return Color( ReadRGBA() )
end

function net.ReadEntity()
	local ent_index = ReadUInt( 13 )
	if ent_index then return Entity( ent_index ) end
end

function net.ReadByte()
	return ReadUInt( 8 )
end

function net.ReadLong()
	return ReadUInt( 32 )
end

function net.ReadPlayer()
	local ent_index = ReadUInt( 8 )
	if ent_index then return Entity( ent_index ) end
end