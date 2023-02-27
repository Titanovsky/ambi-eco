local PLAYER = FindMetaTable( 'Player' )
local Error, Warning, Log, Fetch = Ambi.General.Error, Ambi.General.Warning, Ambi.General.Log, http.Fetch
local MAX_COUNT_RECENTLY_PLAYED_GAMES = 256
local DEFAULT_RETRIES = 2

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:MakeSteamInfoTable( sSteamAPIKey, nRetry )
	if self:IsBot() then return end
	if not sSteamAPIKey then Error( 'Ambi.Player', 'Not selected sSteamAPIKey!' ) return end

	nRetry = nRetry or DEFAULT_RETRIES
	if ( nRetry <= 0 ) then return end

	self.steam_info = {}

    Fetch( 'https://api.steampowered.com/ISteamUser/GetFriendList/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).friendslist.friends

		self.steam_info.friends_list = tab
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/ISteamUser/GetFriendList: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/ISteamUser/GetPlayerBans/v1?key='..sSteamAPIKey..'&steamids='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).players[ 1 ]

		self.steam_info.bans = tab
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/ISteamUser/GetPlayerBans: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64()..'&count='..MAX_COUNT_RECENTLY_PLAYED_GAMES, function( sBody )
		local tab = util.JSONToTable( sBody ).response.games

		self.steam_info.recently_played_games = tab
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/IPlayerService/GetRecentlyPlayedGames: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/IPlayerService/GetOwnedGames/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64()..'&include_appinfo=true&include_played_free_games=true', function( sBody )
		local tab = util.JSONToTable( sBody ).response.games

		self.steam_info.owned_games = tab
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/IPlayerService/GetOwnedGames: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/IPlayerService/GetSteamLevel/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local level = util.JSONToTable( sBody ).response.player_level

		self.steam_info.level = level
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/IPlayerService/GetSteamLevel: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/IPlayerService/GetBadges/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local response = util.JSONToTable( sBody ).response

		self.steam_info.xp = response.player_xp
		self.steam_info.badges = response.badges
		self.steam_info.xp_for_next_level = response.player_xp_needed_to_level_up
		self.steam_info.xp_for_current_level = response.player_xp_needed_current_level
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com/IPlayerService/GetBadges: '..sCode ) 
	end )

	Fetch( 'https://api.steampowered.com/ISteamUser/GetUserGroupList/v1?key='..sSteamAPIKey..'&steamid='..self:SteamID64(), function( sBody )
		local tab = util.JSONToTable( sBody ).response.groups

		self.steam_info.groups = tab
	end, function( sCode ) 
		Error( 'Ambi.Player', 'Error request in api.steampowered.com//ISteamUser/GetUserGroupList: '..sCode ) 
	end )

	timer.Simple( 1, function()
		if not IsValid( self ) then return end
		if self.steam_info then Log( 'SteamInfo table for '..self:SteamID()..' has maked' ) return end

		self:MakeSteamInfoTable( sSteamAPIKey, nRetry - 1 )
	end )
end

function PLAYER:GetSteamInfo()
	return self.steam_info
end

function PLAYER:GetSteamBans( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.bans
end

function PLAYER:GetSteamRecentlyPlayedGames( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.recently_played_games
end

function PLAYER:GetSteamOwnedGames( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.owned_games
end

function PLAYER:GetSteamLevel( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.level
end

function PLAYER:GetSteamXP( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.xp
end

function PLAYER:GetSteamXPForNextLevel( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.xp_for_next_level
end

function PLAYER:GetSteamXPForCurrentLevel( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.xp_for_current_level
end

function PLAYER:GetSteamBadges( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.badges
end

function PLAYER:GetSteamGroups( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.groups
end

function PLAYER:GetSteamFriends( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	return self.steam_info.friends_list
end

function PLAYER:GetSteamOnlineFriends( sSteamAPIKey )
	if not self:GetSteamInfo() then self:MakeSteamInfoTable( sSteamAPIKey ) Warning( 'Ambi.Player', 'The table steam_info dont exists, will be create.' ) return end

	local tab = {}

	for _, v in ipairs( self.steam_info.steam_friends_list ) do
		local ply = player.GetBySteamID64( v.steamid )
		if IsValid( ply ) then tab[ #tab + 1 ] = ply end
	end

	return tab
end