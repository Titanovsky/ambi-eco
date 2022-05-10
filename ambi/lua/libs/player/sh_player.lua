Ambi.Player = Ambi.Player or {}

local PLAYER = FindMetaTable( 'Player' )
setmetatable( Ambi.Player, { __index = PLAYER } )

local Random = Ambi.General.Utility.Random
local util, tostring, IsValid, team = util, tostring, IsValid, team
local TimerCreate, TimerRemove = timer.Create, timer.Remove
local Error, Get = Ambi.General.Error, http.Fetch

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- from: https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L582
function PLAYER:TraceFromEyes( nDist )
    nDist = nDist or 0

	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + ( self:GetAimVector() * nDist )
	trace.filter = self

	return util.TraceLine( trace )
end

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
Ambi.Player.times = Ambi.Player.times or {}

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

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:GetSteamFriendsList( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/ISteamUser/GetFriendList/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).friendslist.friends

		if fAction then fAction( tab ) end

		self.steam_friends_list = tab
	end )

	return self.steam_friends_list
end

function PLAYER:GetSteamOnlineFriends( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	self:GetSteamFriendsList( sSteamAPIKey, function( tFriends ) 
		local tab = {}

		for _, v in ipairs( tFriends ) do
			local ply = player.GetBySteamID64( v.steamid )
			if IsValid( ply ) then tab[ #tab + 1 ] = ply end
		end

		if fAction then fAction( tab ) end

		self.steam_online_friends = tab
	end )

	return self.steam_online_friends
end

function PLAYER:GetSteamBans( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/ISteamUser/GetPlayerBans/v1?key='..sSteamAPIKey..'&steamids='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).players[ 1 ]

		if fAction then fAction( tab ) end

		self.steam_bans = tab
	end )

	return self.steam_bans
end

function PLAYER:GetSteamRecentlyPlayedGames( sSteamAPIKey, nMaxCount, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	nMaxCount = nMaxCount or 0
	nMaxCount = tostring( nMaxCount )

	Get( 'https://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64()..'&count='..nMaxCount, function( sBody )
		local tab = util.JSONToTable( sBody ).response.games

		if fAction then fAction( tab ) end

		self.steam_recently_played_games = tab
	end )

	return self.steam_recently_played_games
end

function PLAYER:GetSteamOwnedGames( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetOwnedGames/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64()..'&include_appinfo=true&include_played_free_games=true', function( sBody )
		local tab = util.JSONToTable( sBody ).response.games

		if fAction then fAction( tab ) end

		self.steam_owned_games = tab
	end )

	return self.steam_owned_games
end

function PLAYER:GetSteamLevel( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetSteamLevel/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local level = util.JSONToTable( sBody ).response.player_level

		if fAction then fAction( level ) end

		self.steam_level = level
	end )

	return self.steam_level
end

function PLAYER:GetSteamXP( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetBadges/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local xp = util.JSONToTable( sBody ).response.player_xp

		self.steam_xp = xp

		if fAction then fAction( xp ) end
	end )

	return self.steam_xp
end

function PLAYER:GetSteamXPForNextLevel( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetBadges/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local xp = util.JSONToTable( sBody ).response.player_xp_needed_to_level_up

		self.steam_xp_next_level = xp

		if fAction then fAction( xp ) end
	end )

	return self.steam_xp_next_level
end

function PLAYER:GetSteamXPForCurrentLevel( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetBadges/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local xp = util.JSONToTable( sBody ).response.player_xp_needed_current_level

		self.steam_xp_current_level = xp

		if fAction then fAction( xp ) end
	end )

	return self.steam_xp_current_level
end

function PLAYER:GetSteamBadges( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/IPlayerService/GetBadges/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).response.badges

		self.steam_badges = tab

		if fAction then fAction( tab ) end
	end )

	return self.steam_badges
end

function PLAYER:GetSteamGroups( sSteamAPIKey, fAction )
	if not sSteamAPIKey then Error( 'Player', 'Not selected sSteamAPIKey!' ) return end

	Get( 'https://api.steampowered.com/ISteamUser/GetUserGroupList/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).response.groups

		self.steam_groups = tab
	end )

	return self.steam_groups
end