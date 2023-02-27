Ambi.General.Utility = Ambi.General.Utility or {}
setmetatable( Ambi.General.Utility, { __index = util } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
local A = Ambi.General
local player, string, ipairs, table, tostring, os, isstring = player, string, ipairs, table, tostring, os, isstring
local surface, IsValid, tonumber = surface, IsValid, tonumber
local math, ents, bit, Vector = math, ents, bit, Vector

-- --------------------------------------------------------------------------------------------------------------------------------------------
function util.FindPlayer( sArg, fData, bOnlyHumans )
    if not fData then A.Error( 'Ambition.Utility', 'Not specified fData' ) return false end

    sArg = sArg or ''
    sArs = string.lower( sArgs )

    local tab, players = bOnlyHumans and player.GetHumans() or player.GetAll(), {}
    for _, ply in ipairs( tab ) do
        local data = string.lower( tostring( fData( ply ) ) )
            
        if string.find( data, sArg ) then table.insert( players, ply ) end
        if ( data == sArg ) then return ply end

    end
    if ( #players == 0 ) or ( #players > 1 ) then return false end

    return players[ 1 ]
end

function util.GetRussianDate( nDate )
    return os.date( '%d.%m.%Y', nDate )
end

function util.GetTextSizeX( sText, sFont )
    if not CLIENT then return end

    surface.SetFont( sFont )
    local x, _ = surface.GetTextSize( sText )

    return x
end

function util.GetTextSizeY( sText, sFont )
    if not CLIENT then return end

    surface.SetFont( sFont )
    local _, y = surface.GetTextSize( sText )

    return y
end

function util.GetFrontPos( eObj, nMultiply )
    if not IsValid( eObj ) then return end

    -- TODO: fix pos, then Entity spawned with nMultiply to Wall or behind Wall

    local shoot_pos = eObj:GetShootPos()
    local aim_pos = eObj:GetAimVector()
    
    return shoot_pos + ( aim_pos * ( nMultiply or 70 ) )
end

function util.GetFrontPosNew( ePly, eObj, nMultiply )
    if not IsValid( eObj ) then return end
    if not IsValid( ePly ) then return end

    local tr = ePly:GetEyeTrace()
    local hitpos = tr.HitPos
    local pos = ePly:GetPos()
    local dis = hitpos - pos

    return hitpos - ( dis ) + Vector( ePly:GetAimVector().x, ePly:GetAimVector().y, 0 ) * ( eObj:BoundingRadius() * 1.5 )
end

function util.UnpackColor( cColor )
    return cColor.r, cColor.g, cColor.b, cColor.a
end

-- -------------------------------------------------------------------------------------
-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/util.lua#L77
function util.Copy( anyVar )
	if not anyVar then return end

	local type = type( anyVar )

	if ( type == 'table' ) then
		local output = {}

		for k, v in pairs( anyVar ) do
			if ( k == anyVar ) or ( v == anyVar ) then continue end

			output[ util.Copy( k ) ] = util.Copy( v )
		end

		return output
	elseif ( type == 'Angle' ) then return Angle( anyVar.p, anyVar.y, anyVar.r )
	elseif ( type == 'Vector' ) then return Vector( anyVar ) 
	end

	return anyVar
end

-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/util.lua#L77
function util.VectorRandom( nX, nY, nZ )
	nX, nY, nZ = nX or 1, nY or 1, nZ or 1

	return Vector( math.Rand( -nX, nX ), math.Rand( -nY, nY ), math.Rand( -nZ, nZ ) )
end

function VectorRandom( nX, nY, nZ )
	return util.VectorRandom( nX, nY, nZ )
end

-- From: https://github.com/Kefta/gs_lib/blob/master/lua/code_gs/lib/util.lua#L66
function util.ClearTrace()
	return {
		Entity = NULL,
		Fraction = 1,
		FractionLeftSolid = 0,
		Hit = false,
		HitBox = 0,
		HitGroup = 0,
		HitNoDraw = false,
		HitNonWorld = false,
		HitNormal = Vector(0, 0, 0),
		HitPos = Vector(0, 0, 0),
		HitSky = false,
		HitTexture = "**empty**",
		HitWorld = false,
		MatType = 0,
		Normal = Vector(0, 0, 0),
		PhysicsBone = 0,
		StartPos = Vector(0, 0, 0),
		SurfaceProps = 0,
		StartSolid = false,
		AllSolid = false
	}
end

-- From: https://github.com/Kefta/gs_lib/blob/master/lua/code_gs/lib/util.lua#L91
function util.TracePlayerBBox( tTable, ePly )
	if not tTable or not ePly then return end

	tTable.mins, tTable.maxs = ePly:Crouching() and ePly:GetHullDuck() or ePly:GetHull()
	tTable.filter = tTable.filter or pPlayer
	
	return util.TraceRay( tTable )
end

-- From: https://github.com/Kefta/gs_lib/blob/master/lua/code_gs/lib/util.lua#L260
function util.TraceRay( tTable )
	if ( tTable.mins and tTable.maxs ) then return util.TraceHull( tTable ) end
	
	return util.TraceLine( tTable )
end

-- -------------------------------------------------------------------------------------
-- From: https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L603
function util.ClassIsNearby( vPos, sClass, nRange )
    -- Refactored this code
    if not sClass or not isstring( sClass ) then return end

    nRange = nRange or 1
    vPos = vPos or Vector( 0, 0, 0 )

	for k, v in pairs( ents.FindInSphere( vPos, nRange ) ) do
		if ( v:GetClass() == sClass ) then 
            local dist = v:GetPos():Distance( vPos )
            if ( dist <= nRange ) then return true end
        end
	end

	return false
end

-- From: https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L614
local VECTOR = Vector( 0, 0, 1 ) -- constant for IsInWater
function util.IsInWater( vPos )
    vPos = vPos or Vector( 0, 0, 0 )

	local trace = {}
	trace.start = vPos
	trace.endpos = vPos + VECTOR
	trace.mask = bit.bor( MASK_WATER, MASK_SOLID )

	return util.TraceLine( trace ).Hit
end

-- Tracer flags
TRACER_FLAG_WHIZ = 0x0001
TRACER_FLAG_USEATTACHMENT = 0x0002
TRACER_DONT_USE_ATTACHMENT = -1
function util.Tracer( vStart, vEnd, eObj, nAttachment, nVel, bWhiz, sCustomTracerName, nParticleID )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/util.lua#L11
    vStart, vEnd = vStart or Vector( 0, 0, 0 ), vEnd or Vector( 0, 0, 0 )

	local data = EffectData()
	data:SetStart( vStart )
	data:SetOrigin( vEnd )
	data:SetEntity( eObj )
	data:SetScale( nVel )

	if ( nParticleID ~= nil ) then data:SetHitBox( nParticleID ) end

	local fFlags = data:GetFlags()
	if bWhiz then fFlags = bit.bor( fFlags, TRACER_FLAG_WHIZ ) end

	if ( nAttachment ~= TRACER_DONT_USE_ATTACHMENT ) then
		fFlags = bit.bor( fFlags, TRACER_FLAG_USEATTACHMENT )
		data:SetAttachment( nAttachment )
	end

	data:SetFlags(fFlags)

	-- Fire it off
	if pCustomTracerName then util.Effect( sCustomTracerName, data)
	else util.Effect( 'Tracer', data )
	end
end

function util.FindHullIntersection( tTab, tTrace )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/util.lua#L45
    if not tTab or not istable( tTab ) then A.Error( 'Ambition.Utility', 'FindHullIntersection | tTab is not selected!' ) return end
    if not tTrace or not istable( tTab ) then A.Error( 'Ambition.Utility', 'FindHullIntersection | tTrace is not selected!' ) return end

	local iDist = 1e12
	tTab.output = nil
	local vSrc = tTab.start
	local vHullEnd = vSrc + ( tTrace.HitPos - vSrc ) * 2
	tTab.endpos = vHullEnd
	local tBounds = { tTab.mins, tTab.maxs }
	local trTemp = util.TraceLine( tTab )

	if (trTemp.Fraction ~= 1) then table.CopyFromTo( trTemp, tTrace ) return tTrace end

	local trOutput

	for i = 1, 2 do
		for j = 1, 2 do
			for k = 1, 2 do
				tTab.endpos = Vector( vHullEnd.x + tBounds[i].x,
					vHullEnd.y + tBounds[j].y,
					vHullEnd.z + tBounds[k].z )

				local trTemp = util.TraceLine( tTab )

				if ( trTemp.Fraction ~= 1 ) then
					local iHitDistSqr = ( trTemp.HitPos - vSrc ):LengthSqr()

					if ( iHitDistSqr < iDist ) then
						trOutput = trTemp
						iDist = iHitDistSqr
					end
				end
			end
		end
	end

	if trOutput then table.CopyFromTo( trOutput, tTrace ) end

	return tTrace
end

local ents_FindInSphere = ents.FindInSphere
local util_PointContents = util.PointContents
local BADPOINTS = {
	[CONTENTS_SOLID] 		= true,
	[CONTENTS_MOVEABLE] 	= true,
	[CONTENTS_LADDER]		= true,
	[CONTENTS_PLAYERCLIP] 	= true,
	[CONTENTS_MONSTERCLIP] 	= true,
}

local function isempty( vPos, nRange )
	if BADPOINTS[ util_PointContents( vPos ) ] then return false end

	local entities = ents_FindInSphere( vPos or Vector( 0, 0, 0 ), nRange or 1 )
	for i = 1, #entities do
		if ( entities[ i ]:GetClass() == 'prop_physics' ) or ( entities[ i ]:IsPlayer() and entities[ i ]:Alive() ) then return false end
	end

	return true
end

-- from: -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/util.lua#L117
function util.FindEmptyPos( vPos, nRange, nSteps )
    vPos = vPos or Vector( 0, 0, 0 )
    nRange = nRange or 0
    nSteps = nSteps or 1

	if isempty( vPos, nRange ) then return vPos end

	for i = 1, nSteps do
		local step = ( i * 50 )
		if isempty( Vector( vPos.x + step, vPos.y, vPos.z ), nRange ) then
			vPos.x = vPos.x + step

			return vPos
		elseif isempty( Vector( vPos.x, vPos.y + step, vPos.z ), nRange ) then
			vPos.y = vPos.y + step

			return vPos
		elseif isempty( Vector( vPos.x, vPos.y, vPos.z + step ), nRange ) then
			vPos.z = vPos.z + step

			return vPos
		end
	end

	return vPos
end

-- -------------------------------------------------------------------------------------
if CLIENT then
	local Material = Material

	local name = GetConVar( 'sv_skyname' ):GetString()
	local AREAS = { 'lf', 'ft', 'rt', 'bk', 'dn', 'up' }
	local TEXTURES = {
		Material( 'skybox/'.. name .. 'lf' ),
		Material( 'skybox/'.. name .. 'ft' ),
		Material( 'skybox/'.. name .. 'rt' ),
		Material( 'skybox/'.. name .. 'bk' ),
		Material( 'skybox/'.. name .. 'dn' ),
		Material( 'skybox/'.. name .. 'up' ),
	}
		
	-- From: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/client/util.lua
	function util.SetSkybox( sSkybox )	
		sSkybox = sSkybox or 'painted'

		for i = 1, 6 do
			TEXTURES[ i ]:SetTexture( '$basetexture', Material( 'skybox/' .. sSkybox .. AREAS[ i ] ):GetTexture( '$basetexture' ) )
		end
	end	
end