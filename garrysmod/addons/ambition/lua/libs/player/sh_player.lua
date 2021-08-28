AMB.Player = AMB.Player or {}

local PLAYER = FindMetaTable( 'Player' )
setmetatable( AMB.Player, { __index = PLAYER } )

-- -------------------------------------------------------------------------------------
local Random = AMB.Ambition.Utility.Random
local util, tostring, IsValid = util, tostring, IsValid
local TimerCreate, TimerRemove = timer.Create, timer.Remove
-- -------------------------------------------------------------------------------------

-- by Odic-Force
function PLAYER:TraceFromEyes( nDist )
    -- Source: https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L582
    nDist = nDist or 0

	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + ( self:GetAimVector() * nDist )
	trace.filter = self

	return util.TraceLine( trace )
end

-- -------------------------------------------------------------------------------------
AMB.Player.times = AMB.Player.times or {}

function PLAYER:SetTimer( sTimer, sDescription, nDelay, nRepeat, fCallback, fFilter, fFailure )
	nDelay = nDelay or 1
	nRepeat = nRepeat or 1

	local sid = self:SteamID()
	if not AMB.Player.times[ sid ] then AMB.Player.times[ sid ] = {} end
    if not sTimer then sTimer = Random.SuperString() end

	AMB.Player.times[ sid ][ sTimer ] = { desc = sDescription, delay = nDelay, rep = nRepeat }

    local name = 'AmbTimerPlayer|'..tostring( self )..'|'..sTimer
    TimerCreate( name, nDelay, nRepeat, function()
		if AMB.Player.times[ sid ] and AMB.Player.times[ sid ][ sTimer ] then AMB.Player.times[ sid ][ sTimer ] = nil end

		if fFilter and not fFilter( self ) then if fFailure then fFailure( self ) end return end
        if not IsValid( self ) then return end

        if fCallback then fCallback( self ) end
    end )
end

function PLAYER:SetTimerSimple( nDelay, fCallback, fFilter, fFailure )
    local name = 'AmbTimerPlayer|'..tostring( self )..'|'..Random.SuperString()
    TimerCreate( name, nDelay or 1, 1, function()
		if fFilter and not fFilter( self ) then if fFailure then fFailure( self ) end return end
        if not IsValid( self ) then return end

        if fCallback then fCallback( self ) end
    end )
end

function PLAYER:RemoveTimer( sTimer )
	sTimer = sTimer or ''
	local sid = self:SteamID()
	if not AMB.Player.times[ sid ] then AMB.Player.times[ sid ] = {} return end
	if not AMB.Player.times[ sid ][ sTimer ] then return end

	TimerRemove( 'AmbTimerPlayer|'..tostring( self )..'|'..sTimer )
end

function PLAYER:RemoveTimers()
	local sid = self:SteamID()
	if not AMB.Player.times[ sid ] then AMB.Player.times[ sid ] = {} return end

	for id, _ in pairs( AMB.Player.times[ sid ] ) do 
		TimerRemove( 'AmbTimerPlayer|'..tostring( self )..'|'..id ) 
	end
end

function PLAYER:GetTimer( sTimer )
	local sid = self:SteamID()
	if not AMB.Player.times[ sid ] then AMB.Player.times[ sid ] = {} end

	return AMB.Player.times[ sid ][ sTimer or '' ]
end

function PLAYER:GetTimers()
	local sid = self:SteamID()
	if not AMB.Player.times[ sid ] then AMB.Player.times[ sid ] = {} end

	return AMB.Player.times[ sid ]
end