Ambi.General.Network = Ambi.General.Network or {}
Ambi.General.Network.strings = Ambi.General.Network.strings or {}
setmetatable( Ambi.General.Network, { __index = net } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
local Gen = Ambi.General
local NetworkIDToString, AddNetworkString, IsValid, Color = util.NetworkIDToString, util.AddNetworkString, IsValid, Color
local Call = hook.Call
local Start, Send, ReadUInt, WriteUInt = net.Start, SERVER and net.Send or net.SendToServer, net.ReadUInt, net.WriteUInt

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.General.Network.AddString( sName, fReceive )
    if not sName then return end

	if fReceive then net.Receive( sName, fReceive ) end

    if SERVER then 
        AddNetworkString( sName ) 
        Ambi.General.Network.strings[ sName ] = true

        return sName
    end
end

function Ambi.General.Network.GetStrings()
    return Ambi.General.Network.strings
end

-- -------------------------------------------------------------------------------------
function Ambi.General.Network.SafeStart( sName )
	sName = sName:lower()

	if Ambi.General.Network.strings[ sName ] or net.Receivers[ sName ] then return Start( sName ) end

	Ambi.General.Network.AddString( sName )

	return Start( sName )
end

function Ambi.General.Network.Ping( ePly, sMsg )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/net.lua
	Start( sMsg )
	Send( ePly )

    hook.Call( '[Ambi.General.Network.Ping]', nil, sMsg, ePly )
end

function Ambi.General.Network.SendFilter( fFilter )
	if CLIENT or not fFiler then return end

	for _, ply in ipairs( player.GetAll() ) do
		if fFilter( ply ) then net.Send( ply ) end
	end
end

-- -------------------------------------------------------------------------------------
function Ambi.General.Network.WriteEntity( eObj )
	-- by SuperiorServers
	-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/net.lua

	if IsValid( eObj ) then
		WriteUInt( eObj:EntIndex(), 13 )
	else
		WriteUInt( 0, 13 )
	end
end

function Ambi.General.Network.WriteByte( nByte )
	WriteUInt( nByte, 8 )
end

function Ambi.General.Network.WriteRGB( nRed, nGreen, nBlue )
	WriteUInt( nRed, 8 )
	WriteUInt( nGreen, 8 )
	WriteUInt( nBlue, 8 )
end

function Ambi.General.Network.WriteRGBA( nRed, nGreen, nBlue, nAlpha )
	WriteUInt( nRed, 8 )
	WriteUInt( nGreen, 8 )
	WriteUInt( nBlue, 8 )
	WriteUInt( nAlpha, 8 )
end

local WriteRGBA = Ambi.General.Network.WriteRGBA

function Ambi.General.Network.WriteColor( cColor )
	WriteRGBA( cColor.r, cColor.g, cColor.b, cColor.a )
end

function Ambi.General.Network.WriteNibble( nNibble )
	WriteUInt( nNibble, 4 )
end

function Ambi.General.Network.ReadShort()
	return ReadUInt( 16 )
end

function Ambi.General.Network.WriteShort( nShort )
	WriteUInt( nShort, 16 )
end

function Ambi.General.Network.WriteLong( nLong )
	WriteUInt( nLong, 32 )
end

function Ambi.General.Network.WritePlayer( ePly )
	if IsValid( ePly ) then
		WriteUInt( ePly:EntIndex(), 8 )
	else
		WriteUInt( 0, 8 )
	end
end

-- -------------------------------------------------------------------------------------
function Ambi.General.Network.ReadNibble()
	return ReadUInt( 4 )
end

function Ambi.General.Network.ReadRGB()
	return ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 )
end

function Ambi.General.Network.ReadRGBA()
	return ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 ), ReadUInt( 8 )
end

local ReadRGBA = Ambi.General.Network.ReadRGBA

function Ambi.General.Network.ReadColor()
	return Color( ReadRGBA() )
end

function Ambi.General.Network.ReadEntity()
	local ent_index = ReadUInt( 13 )
	if ent_index then return Entity( ent_index ) end
end

function Ambi.General.Network.ReadByte()
	return ReadUInt( 8 )
end

function Ambi.General.Network.ReadLong()
	return ReadUInt( 32 )
end

function Ambi.General.Network.ReadPlayer()
	local ent_index = ReadUInt( 8 )
	if ent_index then return Entity( ent_index ) end
end

-- -------------------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' ) 

function PLAYER:PingNetwork( sMsg )
	Ambi.General.Network.Ping( self, sMsg )
end

-- -------------------------------------------------------------------------------------

-- Решил этот боттлнек очень простым путём. Не стал ничего менять, пусть всё так и будет
for k, v in pairs( AMB.General.Network ) do
	if isfunction( v ) then
		net[ k ] = v
	end
end