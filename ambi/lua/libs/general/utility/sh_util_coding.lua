Ambi.General.Utility.Coding = Ambi.General.Utility.Coding or {}
util.Coding = util.Coding or {}
setmetatable( Ambi.General.Utility.Coding, { __index = util.Coding } )

-- --------------------------------------------------------------------------------------------------------------------------------------------
local format, byte, gsub, char = string.format, string.byte, string.gsub, string.char

-- --------------------------------------------------------------------------------------------------------------------------------------------
function util.Coding.CharToHEX( sChar )
	-- Source: https://gist.github.com/liukun/f9ce7d6d14fa45fe9b924a3eed5c3d99
    return format( '%%%02X', byte( sChar or '' ) )
end

function util.Coding.HEXToChar( sHEX )
    return char( tonumber( sHEX or '', 16 ) )
end

function util.Coding.EncodeURL( sStr )
    if ( sStr == nil ) then return '' end

    local url = ''
    url = gsub( sStr, '\n', '\r\n' )
    url = gsub( url, '([^%w ])', util.Coding.CharToHEX )
    url = gsub( url, ' ', '+' )
    
    return url
end

function util.Coding.DecodeURL( sUrl )
    if ( sUrl == nil ) then return '' end

    local str = ''
    str = gsub( sUrl, '+', ' ' )
    str = gsub( str, '%%(%x%x)', Ambi.General.Utility.Coding.CharToHEX )

    return str
end

function util.Coding.RGBToAnsi256( nRed, nGreen, nBlue )
	-- by SuperiorServers
	-- Source: https://github.com/SuperiorServers/dash/blob/a0d4347371503b1577d72bed5f6df46d48909f56/lua/dash/extensions/server/console.lua
    // https://stackoverflow.com/questions/15682537/ansi-color-specific-rgb-sequence-bash?answertab=votes#tab-top
	if ( nRed == nGreen ) and ( nGreen == nBlue ) then
		if ( nRed < 8 ) then return 16 end
		if ( nRed > 248 ) then return 231 end

		return math.Round( ( ( nRed - 8 ) / 247 ) * 24 ) + 232
	end

	return 16 + ( 36 * math.Round( nRed / 255 * 5 ) ) + ( 6 * math.Round( nGreen / 255 * 5 ) ) + math.Round( nBlue / 255 * 5 )
end

local PATTERN = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function util.Coding.Base64Decode( sString )
	data = gsub( sString or '', '[^'..PATTERN..'=]', '' )

	return ( data:gsub( '.', function( x )
		if ( x == '=' ) then return '' end

		local r, f = '',( PATTERN:find( x ) - 1 )
		for i = 6, 1, -1 do r = r..( f % 2 ^ i - f % 2 ^ ( i - 1 ) > 0 and '1' or '0' ) end
        
		return r;
	end):gsub( '%d%d%d?%d?%d?%d?%d?%d?', function( x )
		if ( #x ~= 8 ) then return '' end

		local c = 0
		for i= 1, 8 do c = c + ( x:sub( i, i ) == '1' and 2 ^ ( 8 - i ) or 0 ) end

		return string.char( c )
	end ) )
end

function util.Coding.EncodeNormalSteamID( sSteamID )
	-- 'STEAM_0:1:95303327'
	sSteamID = string.sub( sSteamID, 7, #sSteamID )
	sSteamID = string.Replace( sSteamID, ':', '_' )

	return sSteamID
end

function util.Coding.DecodeNormalSteamID( sSteamID )
	sSteamID = string.Replace( sSteamID, '_', ':' )
	sSteamID = 'STEAM_'..sSteamID

	return sSteamID
end