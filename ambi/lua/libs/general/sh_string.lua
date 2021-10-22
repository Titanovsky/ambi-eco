Ambi.General.String = Ambi.General.String or {}
setmetatable( Ambi.General.String, { __index = string } )

-- -------------------------------------------------------------------------------------
local A = Ambi.General
local KEYS = nil
local string, ipairs, isstring, utf8, ipairs, tonumber = string, ipairs, isstring, utf8, ipairs, tonumber
local Explode, Trim, Char, GSub = string.Explode, string.Trim, string.char, string.gsub
local Random = math.random
local rshift, band = bit.rshift, bit.band
-- -------------------------------------------------------------------------------------

RUSSIAN_CHARS_UPPER = {
	[ 'ё' ] = 'Ё',
	[ 'й' ] = 'Й',
	[ 'ц' ] = 'Ц',
	[ 'у' ] = 'У',
	[ 'к' ] = 'К',
	[ 'е' ] = 'Е',
	[ 'н' ] = 'Н',
	[ 'г' ] = 'Г',
	[ 'ш' ] = 'Ш',
	[ 'щ' ] = 'Щ',
	[ 'з' ] = 'З',
	[ 'х' ] = 'Х',
	[ 'ъ' ] = 'Ъ',
	[ 'ф' ] = 'Ф',
	[ 'ы' ] = 'Ы',
	[ 'в' ] = 'В',
	[ 'а' ] = 'А',
	[ 'п' ] = 'П',
	[ 'р' ] = 'Р',
	[ 'о' ] = 'О',
	[ 'л' ] = 'Л',
	[ 'д' ] = 'Д',
	[ 'ж' ] = 'Ж',
	[ 'э' ] = 'Э',
	[ 'я' ] = 'Я',
	[ 'ч' ] = 'Ч',
	[ 'с' ] = 'С',
	[ 'м' ] = 'М',
	[ 'и' ] = 'И',
	[ 'т' ] = 'Т',
	[ 'ь' ] = 'Ь',
	[ 'б' ] = 'Б',
	[ 'ю' ] = 'Ю',
}

RUSSIAN_CHARS_LOWER = {}
for low_char, up_char in pairs( RUSSIAN_CHARS_UPPER ) do
	RUSSIAN_CHARS_LOWER[ up_char ] = low_char
end

local Lower = string.lower
function string.ForceLower( sString )
	local str = ''
	local len = utf8.len( sString )
	if ( len == 1 ) then return Lower( RUSSIAN_CHARS_LOWER[ sString ] or sString ) end

	for i = 1, len do
		local char = utf8.GetChar( sString, i )
		local reverse = RUSSIAN_CHARS_LOWER[ char ]
		if reverse then str = str..reverse else str = str..char  end
	end

	return Lower( str )
end

local Upper = string.upper
function string.ForceUpper( sString )
	local str = ''
	local len = utf8.len( sString )
	if ( len == 1 ) then return Upper( RUSSIAN_CHARS_UPPER[ sString ] or sString ) end

	for i = 1, len do
		local char = utf8.GetChar( sString, i )
		local reverse = RUSSIAN_CHARS_UPPER[ char ]
		if reverse then str = str..reverse else str = str..char  end
	end

	return Upper( str )
end

function string.IsRussianUpChar( sChar )
	return tobool( RUSSIAN_CHARS_LOWER[ sChar ] )
end

function string.IsRussianLowerChar( sChar )
	return tobool( RUSSIAN_CHARS_UPPER[ sChar ] )
end

-- -------------------------------------------------------------------------------------

function string.IsValid( sString )
    if not sString or not isstring( sString ) then return false end

    for _, char in ipairs( Explode( '', sString ) ) do
        if ( char ~= ' ' ) then return true end
    end

    return false
end

function string.ToSafe( sString )
    if not KEYS then KEYS = Ambi.General.Global.Keys end

    local str = sString or ''

    local new_str = ''
    for i = 1, #str do
        if KEYS.BLACKLIST[ str[ i ] ] then continue end 

        new_str = new_str..str[ i ]
    end
    new_str = Trim( new_str, ' ' )

    return new_str
end

-- -------------------------------------------------------------------------------------

EXPLODE_CLASSIC, EXPLODE_DASH = 0, 1

function string.ExplodeDash( sSeparator )
    if ( separator == '' ) then return totable( str ) end

	if withpattern == nil then
		withpattern = false
	end

	local ret = {}
	local current_pos = 1

	for i = 1, string_len(str) do
		local start_pos, end_pos = string_find(str, separator, current_pos, not withpattern)
		if not start_pos then break end
		ret[i] = string_sub(str, current_pos, start_pos - 1)
		current_pos = end_pos + 1
	end

	ret[#ret + 1] = string_sub(str, current_pos)

	return ret
end

function string.ExplodeCustom( nType, sSeparator, sStr, bPattern )
    nType = nType or 0

    if ( nType == 1 ) then return string.ExplodeDash( sSeparator, sStr, bPattern )
    else return string.Explode( sSeparator, sStr, bPattern )
    end
end

-- -------------------------------------------------------------------------------------

-- by Odic-Force
function string.Capitalize( sString )
    -- https://github.com/Odic-Force/GMStranded/blob/master/gamemodes/GMStranded/gamemode/init.lua#L572
    -- update like Python
    sString = sString or ''
    sString = string.lower( sString )

	local str = Explode( '_', sString )
	for k, v in ipairs( str ) do
        local sub1, sub2 = string.sub( v, 1, 1 ), string.sub( v, 2 )
		str[ k ] = string.upper( sub1 )..sub2
	end

	str = string.Implode( '_', str )

	return str
end

-- -------------------------------------------------------------------------------------
-- by SuperiorServers
-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua

function string.Random( nChars )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L1
    nChars = nChars or 1
    if ( nChars > 256 ) or ( nChars <= 0 ) then A.Error( 'General.String', 'Random | nChars is very long or small ( 0 > nChars > 256)' ) return '' end

    local str = ''
    for i = 1, ( nChars or 1 ) do
        str = str..Char( Random( 97, 122 ) ) 
    end

    return str
end

function string:IsAlphaNumeric()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L9
    return ( not self:match( '%W' ) )
end

function string:StartWith( sStr )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L13
    return ( self:sub( 1, sStr:len() ) == sStr )
end

function string:Apostrophe()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L17
    local len = self:len()
    
    return ( self:sub( len, len ):lower() == 's' ) and '\'' or '\'s'
end

function string:AOrAn()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L22
    return self:match( '^h?[AaEeIiOoUu]' ) and 'an' or 'a'
end

function string:IsSteamID32( sStr )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L26
	return self:match( '^STEAM_%d:%d:%d+$' )
end

function string:IsSteamID64()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L30
	return ( self:len() == 17 ) and ( self:sub( 1, 4 ) == '7656' )
end

function string:HtmlSafe()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L34
	return self:gsub( '&', '&amp;' ):gsub( '<', '&lt;' ):gsub( '>', '&gt;' )
end

local FORMATHEX = '%%%02X'
function string:URLEncode()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L38
	return GSub( GSub( GSub( self, '\n', '\r\n' ), '([^%w ])', function( c )
		return string.format( FORMATHEX, string.byte( c ) )
	end ), ' ', '+' )
end

function string:URLDecode()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L45
	return self:gsub( '+', ' ' ):gsub( '%%(%x%x)', function( hex )
		return Char( tonumber( hex, 16 ) )
	end )
end

function string:ParseURL()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L51
	local ans = {}
	for k, v in self:gmatch('([^&=?]-)=([^&=?]+)' ) do
		ans[ k ] = v:URLDecode()
	end

	return ans
end

function string.ExplodeQuotes( sStr ) -- TODO from original: Re-do this one of these days
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L59
	str = ' ' .. sStr .. ' '
	local res = {}
	local ind = 1
	while true do
		local sInd, start = str:find('[^%s]', ind)
		if not sInd then break end
		ind = sInd + 1
		local quoted = str:sub(sInd, sInd):match('["\']') and true or false
		local fInd, finish = str:find(quoted and '["\']' or '[%s]', ind)
		if not fInd then break end
		ind = fInd + 1
		local str = str:sub(quoted and sInd + 1 or sInd, fInd - 1)
		res[#res + 1] = str
	end
	return res
end

function string:StripPort()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L77
	local p = self:find(':')
	return ( not p ) and ip or self:sub( 1, p - 1 )
end

function string.FromNumbericIP( nIP )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L82
	nIP = tonumber( nIP )
	return rshift( band( nIP, 0xFF000000 ), 24 ) .. '.' .. rshift( band( nIP, 0x00FF0000 ), 16 )..'.'..rshift( band( nIP, 0x0000FF00 ), 8 )..'.'..band( nIP, 0x000000FF )
end

-- Stolen from maestro
local TIME_SECOND = 1
local TIME_MINUTE = TIME_SECOND * 60
local TIME_HOUR = TIME_MINUTE * 60
local TIME_DAY = TIME_HOUR * 24
local TIME_WEEK = TIME_DAY * 7
local TIME_MONTH = TIME_DAY * 30.4368 -- (365.2425/12)
local TIME_YEAR = TIME_DAY * 365.2425

local function plural( sStr, nAmount )
    return ( nAmount == 1 ) and sStr or  sStr..'s'
end

function string.FormatTimeDash( nTime, nLimit )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L100
    num = nTime or 0
    limit = nLimit or 1

	local ret = {}
	while (not limit) or (limit ~= 0) do
		local templimit = limit or 0

		if (num >= TIME_YEAR) or (templimit <= -7) then
			local c = math.floor(num / TIME_YEAR)
			ret[#ret + 1] = c .. ' ' .. plural('year', c)
			num = num - TIME_YEAR * c

		elseif (num >= TIME_MONTH) or (templimit <= -6) then
			local c = math.floor(num / TIME_MONTH)
			ret[#ret + 1] = c .. ' ' .. plural('month', c)
			num = num - TIME_MONTH * c

		elseif (num >= TIME_WEEK) or (templimit <= -5) then
			local c = math.floor(num / TIME_WEEK)
			ret[#ret + 1] = c .. ' ' .. plural('week', c)
			num = num - TIME_WEEK * c

		elseif (num >= TIME_DAY) or (templimit <= -4)then
			local c = math.floor(num / TIME_DAY)
			ret[#ret + 1] = c .. ' ' .. plural('day', c)
			num = num - TIME_DAY * c

		elseif (num >= TIME_HOUR) or (templimit <= -3) then
			local c = math.floor(num / TIME_HOUR)
			ret[#ret + 1] = c .. ' ' .. plural('hour', c)
			num = num - TIME_HOUR * c

		elseif (num >= TIME_MINUTE) or (templimit <= -2) then
			local c = math.floor(num / TIME_MINUTE)
			ret[#ret + 1] = c .. ' ' .. plural('minute', c)
			num = num - TIME_MINUTE * c

		elseif num >= TIME_SECOND or (templimit <= -1) then
			local c = math.floor(num / TIME_SECOND)
			ret[#ret + 1] = c .. ' ' .. plural('second', c)
			num = num - TIME_SECOND * c

		else break
		end

		if limit then
			if ( limit > 0 ) then limit = limit - 1
			else limit = limit + 1
			end
		end
	end

	local str = ''
	for i = 1, #ret do
		if ( i == 1 ) then str = str..ret[ i ]
		elseif ( i == #ret ) then str = str..' and '..ret[ i ]
		else str = str..', '..ret[ i ]
		end
	end

	return str
end

function string:MaxCharacters( nAmount, bWithEllipses )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L187
    nAmount = nAmount or 1

    if not isnumber( nAmount ) then A.Error( 'General.String', 'MaxCharacters | nAmount is not selected!' ) return self end
	if ( #self <= nAmount ) then return self end

	local str = self:sub( 1, nAmount )

	return bWithEllipses and ( str..'...' ) or str
end

local SIMPLE_TIMESTAMP_PATTERN = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
function string.ToTimeDash( sStr )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L196
    sStr = sStr or ''

    local year, month, day, hour, min, sec = sStr:match( SIMPLE_TIMESTAMP_PATTERN )

    return os.time( {
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = min,
        sec = sec
    } )
end

function string.NiceDateDash( sStr )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/string.lua#L210
    -- Like string.NiceTime but for timestamps: 2021-04-08 00:56:24
    return string.NiceTime( string.ToTimeDash( sStr or '' ) )
end

-- -------------------------------------------------------------------------------------

function string.ReplaceFull( sStr, sReplace )
	local str = ''
	for i = 1, #sStr do str = str..sReplace end
	
	return str
end

-- -------------------------------------------------------------------------------------

function string.FindObsceneWords( sStr )
	if not sStr or not isstring( sStr ) then A.Error( 'General.String', 'RemoveObsceneWords | sStr is not selected!' ) return '' end

	return Ambi.General.Global.Words.OBSCENE[ sStr ]
end

function string.ReplaceObsceneWords( sStr )
	local str = ''
	for i = 1, utf8.len( sStr ) do str = str..'*' end
	
	return str
end