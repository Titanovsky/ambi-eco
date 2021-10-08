Ambi.General.Color = Ambi.General.Color or {}

local COLOR = FindMetaTable( 'Color' )
setmetatable( Ambi.General.Color, { __index = COLOR } )

-- -------------------------------------------------------------------------------------
local tonumber, Lerp = tonumber, Lerp
local Format, Match = string.format, string.match
local Round = math.Round
local BAND, RSHIFT = bit.band, bit.rshift
-- -------------------------------------------------------------------------------------
-- by SuperiorServers
-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua

function Color( nRed, nGreen, nBlue, nAlpha )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L10
    return setmetatable( {
		r = tonumber( nRed ) or 255,
		g = tonumber( nGreen ) or 255,
		b = tonumber( nBlue ) or 255,
		a = tonumber( nAlpha ) or 255
	}, COLOR )
end

function COLOR:Copy()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L19
    return Color( self.r, self.g, self.b, self.a )
end

function COLOR:Unpack()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L23
    return self.r, self.g, self.b, self.a
end

function COLOR:SetHEX( sHEX )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L27
    local r, g, b = Match( sHEX or '', '#(..)(..)(..)' )
    self.r, self.g, self.b = tonumber( r, 16 ), tonumber( g, 16 ), tonumber( b, 16 )
end

function COLOR:ToHEX()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L32
    return Format( '#%02X%02X%02X', self.r, self.g, self.b )
end

function COLOR:SetEncodedRGB( nNum )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L36
    nNum = nNum or 0

    self.r, self.g, self.b = BAND( RSHIFT( nNum, 16 ), 0xFF ), BAND( RSHIFT( nNum, 8 ), 0xFF ), BAND( nNum, 0xFF )
end

function COLOR:ToEncodedRGB()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L40
    return ( self.r * 0x100 + self.g ) * 0x100 + self.b
end

function COLOR:SetEncodeRGBA( nNum )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L44
    nNum = nNum or 0

    self.r, self.g, self.b, self.a = BAND( RSHIFT( nNum, 16 ), 0xFF ), BAND( RSHIFT( nNum, 8 ), 0xFF ), BAND( nNum, 0xFF ), BAND( RSHIFT( nNum, 24 ), 0xFF )
end

function COLOR:ToEncodedRGBA()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L48
    return ( ( self.a * 0x100 + self.r ) * 0x100 + self.g ) * 0x100 + self.b
end

local COLOR_WHITE, COLOR_BLACK = Color( 255, 255, 255 ), Color( 0, 0, 0 )
function COLOR:Lerp( nFraction, cFrom, cTo )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L52
    nFraction = nFraction or 0.1
    cFrom = cFrom or COLOR_BLACK
    cTo = cTo or COLOR_WHITE

    self.r, self.g, self.b = Lerp( nFraction, cFrom.r, cTo.r ), Lerp( nFraction, cFrom.g, cTo.g ), Lerp( nFraction, cFrom.b, cTo.b ), Lerp( nFraction, cFrom.a, cTo.a )
end

function COLOR:IsLight()
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L56
    local _, _, l = ColorToHSL( self )

    return ( l >= 0.5 )
end

function COLOR:InverseLight( cColor, bSnap )
    -- https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua#L61
    cColor = cColor or COLOR_WHITE
    local snap = bSnap and Round( 1 - l ) or ( 1 - l )

    local _, _, l = ColorToHSL( self )
    local h, s, _ = ColorToHSL( cColor )

    return HSLToColor( h, s, snap )
end