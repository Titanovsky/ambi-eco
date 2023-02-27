Ambi.Player = Ambi.Player or {}
Ambi.Player.times = Ambi.Player.times or {}

local PLAYER = FindMetaTable( 'Player' )
setmetatable( Ambi.Player, { __index = PLAYER } )

local Random = Ambi.General.Utility.Random
local util, tostring, IsValid, team = util, tostring, IsValid, team
local TimerCreate, TimerRemove = timer.Create, timer.Remove
local Error = Ambi.General.Error

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:TraceFromEyes( nDist )
	-- from: https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L582

    nDist = nDist or 0

	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + ( self:GetAimVector() * nDist )
	trace.filter = self

	return util.TraceLine( trace )
end

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:SetTimer( sTimer, sDescription, nDelay, nRepeat, fCallback, fFilter, fFailure )
	nDelay = nDelay or 1
	nRepeat = nRepeat or 1

	local sid = self:SteamID()
	if not Ambi.Player.times[ sid ] then Ambi.Player.times[ sid ] = {} end
    if not sTimer then sTimer = Random.SuperString() end

	Ambi.Player.times[ sid ][ sTimer ] = { desc = sDescription, delay = nDelay, rep = nRepeat }

    local name = 'AmbTimerPlayer|'..tostring( self )..'|'..sTimer
    TimerCreate( name, nDelay, nRepeat, function()
		if Ambi.Player.times[ sid ] and Ambi.Player.times[ sid ][ sTimer ] then Ambi.Player.times[ sid ][ sTimer ] = nil end

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
	if not Ambi.Player.times[ sid ] then Ambi.Player.times[ sid ] = {} return end
	if not Ambi.Player.times[ sid ][ sTimer ] then return end

	TimerRemove( 'AmbTimerPlayer|'..tostring( self )..'|'..sTimer )
end

function PLAYER:RemoveTimers()
	local sid = self:SteamID()
	if not Ambi.Player.times[ sid ] then Ambi.Player.times[ sid ] = {} return end

	for id, _ in pairs( Ambi.Player.times[ sid ] ) do 
		TimerRemove( 'AmbTimerPlayer|'..tostring( self )..'|'..id ) 
	end
end

function PLAYER:GetTimer( sTimer )
	local sid = self:SteamID()
	if not Ambi.Player.times[ sid ] then Ambi.Player.times[ sid ] = {} end

	return Ambi.Player.times[ sid ][ sTimer or '' ]
end

function PLAYER:GetTimers()
	local sid = self:SteamID()
	if not Ambi.Player.times[ sid ] then Ambi.Player.times[ sid ] = {} end

	return Ambi.Player.times[ sid ]
end

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:SetDelay( sDelay, nTime, nRepetitions, fAction )
	if not sDelay then return end

	nTime = nTime or 1
	nRepetitions = nRepetitions or 1

    local id = self:SteamID()

	timer.Create( sDelay..'['..id..']', nTime, nRepetitions, fAction or function() end )
end

function PLAYER:GetDelay( sDelay )
    local id = self:SteamID()

	return timer.Exists( sDelay..'['..id..']' ) and math.floor( timer.TimeLeft( sDelay..'['..id..']' ) ) or nil
end

function PLAYER:CheckDelay( sDelay, fFail, fSuccess )
	if self:GetDelay( sDelay ) then
		if fFail then fFail( self ) end

		return true
	else
		if fSuccess then fSuccess( fSuccess ) end

		return false
	end
end

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:TeamName()
	return team.GetName( self:Team() )
end

function PLAYER:TeamColor()
	return team.GetColor( self:Team() )
end

function PLAYER:TeamClass()
	return team.GetClass( self:Team() )
end

function PLAYER:TeamScore()
	return team.GetScore( self:Team() )
end

function PLAYER:TeamPlayers()
	return team.GetPlayers( self:Team() )
end

function PLAYER:TeamCount()
	return team.NumPlayers( self:Team() )
end

function PLAYER:IsTeamJoinable()
	return team.Joinable( self:Team() )
end

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:Weapon()
	return self:GetActiveWeapon()
end

function PLAYER:Gun()
	return self:GetActiveWeapon()
end

function PLAYER:ActiveWeapon()
	return self:GetActiveWeapon()
end

function PLAYER:IsAlive()
	return self:Alive()
end

function PLAYER:GetSteamID()
	return self:SteamID()
end

function PLAYER:GetSteamID64()
	return self:SteamID64()
end

function PLAYER:RunSpeed()
	return self:GetRunSpeed()
end

function PLAYER:WalkSpeed()
	return self:GetWalkSpeed()
end