Ambi.General.Math = Ambi.General.Math or {}
setmetatable( Ambi.General.Math, { __index = math } )

local math_cos, math_sin, pi = math.cos, math.sin, math.pi

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------- --
function math.Lerp( nT, nA, nB )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L25
    return nA + ( nB - nA ) * nT
end

function math.SDKSimpleSpline( nValue )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L42
    local sqrt = nValue * nValue

    return 3 * sqrt - 2 * sqrt * nValue
end

function math.LerpQuintic( nT, nA, nB )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L55
    if ( t < 0 ) then return nA end
	if ( t >= 1 ) then return nB end

	local value = nT * nT * nT * ( nT * ( nT * 6 - 15 ) + 10 )

	return math.Lerp( value, nA, nB )
end

function math.Quintic( nT )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L70
	return nT * nT * nT * ( nT * ( nT * 6 - 15 ) + 10 )
end

function math.LerpCosine( nT, nA, nB )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L82
	if ( t < 0 ) then return nA end
	if ( t >= 1 ) then return nB end

	local value = ( 1 - math_cos( nT * pi ) ) / 2

	return math.Lerp( value, nA, nB )
end

function math.Cosine( nT )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L97
	return ( 1 - math_cos( nT * pi ) ) / 2
end

function math.LerpSinusine( nT, nA, nB )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L109
	if ( t < 0 ) then return nA end
	if ( t >= 1 ) then return nB end

	local value = ( 1 - math_sin( nT * pi ) ) / 2

	return math.Lerp( value, nA, nB )
end

function math.Sinusine( nT )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L124
	return ( 1 - math_sin( nT * pi ) ) / 2
end

function math.LerpCubic( nT, nA, nB )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L136
	if ( t < 0 ) then return nA end
	if ( t >= 1 ) then return nB end

	local value = -2 * nT * nT * nT + 3 * nT * nT

	return math.Lerp( value, nA, nB )
end

function math.Cubic( nT )
	-- from: https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/lerp.lua#L151
	return -2 * nT * nT * nT + 3 * nT * nT
end

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------- --
-- from: https://github.com/Kefta/gs_lib/blob/master/lua/code_gs/lib/math.lua

local band = bit.band
local bnot = bit.bnot
local bor = bit.bor
local bxor = bit.bxor
local rshift = bit.rshift
local floor = math.floor
local log = math.log
local sin = math.sin
local cos = math.cos
local rad = math.rad
local abs = math.abs
local exp = math.exp

// The four core functions - F1 is optimized somewhat
// local function f1(x, y, z) bit.bor(bit.band(x, y), bit.band(bit.bnot(x), z)) end
// This is the central step in the MD5 algorithm.
local function Step1(w, x, y, z, flData, iStep)
	w = w + bxor(z, band(x, bxor(y, z))) + flData
	
	return bor((w * 2^iStep) % 0x100000000, floor(w % 0x100000000 / 2^(0x20 - iStep))) + x
end

local function Step2(w, x, y, z, flData, iStep)
	w = w + bxor(y, band(z, bxor(x, y))) + flData
	
	return bor((w * 2^iStep) % 0x100000000, floor(w % 0x100000000 / 2^(0x20 - iStep))) + x
end

local function Step3(w, x, y, z, flData, iStep)
	w = w + bxor(bxor(x, y), z) + flData
	
	return bor((w * 2^iStep) % 0x100000000, floor(w % 0x100000000 / 2^(0x20 - iStep))) + x
end

local function Step4(w, x, y, z, flData, iStep)
	w = w + bxor(y, bor(x, bnot(z))) + flData
	
	return bor((w * 2^iStep) % 0x100000000, floor(w % 0x100000000 / 2^(0x20 - iStep))) + x
end

function math.MD5Random(iSeed)
	-- FIXME: Add paragraph
	-- https://github.com/Facepunch/garrysmod-issues/issues/2820
	local bEnabled = jit.status()
	
	if (bEnabled) then
		jit.off()
	end
	
	iSeed = iSeed % 0x100000000
	
	local a = Step1(0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, iSeed + 0xd76aa478, 7)
	local d = Step1(0x10325476, a, 0xefcdab89, 0x98badcfe, 0xe8c7b7d6, 12)
	local c = Step1(0x98badcfe, d, a, 0xefcdab89, 0x242070db, 17)
	local b = Step1(0xefcdab89, c, d, a, 0xc1bdceee, 22)
	a = Step1(a, b, c, d, 0xf57c0faf, 7)
	d = Step1(d, a, b, c, 0x4787c62a, 12)
	c = Step1(c, d, a, b, 0xa8304613, 17)
	b = Step1(b, c, d, a, 0xfd469501, 22)
	a = Step1(a, b, c, d, 0x698098d8, 7)
	d = Step1(d, a, b, c, 0x8b44f7af, 12)
	c = Step1(c, d, a, b, 0xffff5bb1, 17)
	b = Step1(b, c, d, a, 0x895cd7be, 22)
	a = Step1(a, b, c, d, 0x6b901122, 7)
	d = Step1(d, a, b, c, 0xfd987193, 12)
	c = Step1(c, d, a, b, 0xa67943ae, 17)
	b = Step1(b, c, d, a, 0x49b40821, 22)
	
	a = Step2(a, b, c, d, 0xf61e25e2, 5)
	d = Step2(d, a, b, c, 0xc040b340, 9)
	c = Step2(c, d, a, b, 0x265e5a51, 14)
	b = Step2(b, c, d, a, iSeed + 0xe9b6c7aa, 20)
	a = Step2(a, b, c, d, 0xd62f105d, 5)
	d = Step2(d, a, b, c, 0x02441453, 9)
	c = Step2(c, d, a, b, 0xd8a1e681, 14)
	b = Step2(b, c, d, a, 0xe7d3fbc8, 20)
	a = Step2(a, b, c, d, 0x21e1cde6, 5)
	d = Step2(d, a, b, c, 0xc33707f6, 9)
	c = Step2(c, d, a, b, 0xf4d50d87, 14)
	b = Step2(b, c, d, a, 0x455a14ed, 20)
	a = Step2(a, b, c, d, 0xa9e3e905, 5)
	d = Step2(d, a, b, c, 0xfcefa3f8, 9)
	c = Step2(c, d, a, b, 0x676f02d9, 14)
	b = Step2(b, c, d, a, 0x8d2a4c8a, 20)

	a = Step3(a, b, c, d, 0xfffa3942, 4)
	d = Step3(d, a, b, c, 0x8771f681, 11)
	c = Step3(c, d, a, b, 0x6d9d6122, 16)
	b = Step3(b, c, d, a, 0xfde5382c, 23)
	a = Step3(a, b, c, d, 0xa4beeac4, 4)
	d = Step3(d, a, b, c, 0x4bdecfa9, 11)
	c = Step3(c, d, a, b, 0xf6bb4b60, 16)
	b = Step3(b, c, d, a, 0xbebfbc70, 23)
	a = Step3(a, b, c, d, 0x289b7ec6, 4)
	d = Step3(d, a, b, c, iSeed + 0xeaa127fa, 11)
	c = Step3(c, d, a, b, 0xd4ef3085, 16)
	b = Step3(b, c, d, a, 0x04881d05, 23)
	a = Step3(a, b, c, d, 0xd9d4d039, 4)
	d = Step3(d, a, b, c, 0xe6db99e5, 11)
	c = Step3(c, d, a, b, 0x1fa27cf8, 16)
	b = Step3(b, c, d, a, 0xc4ac5665, 23)
	
	a = Step4(a, b, c, d, iSeed + 0xf4292244, 6)
	d = Step4(d, a, b, c, 0x432aff97, 10)
	c = Step4(c, d, a, b, 0xab9423c7, 15)
	b = Step4(b, c, d, a, 0xfc93a039, 21)
	a = Step4(a, b, c, d, 0x655b59c3, 6)
	d = Step4(d, a, b, c, 0x8f0ccc92, 10)
	c = Step4(c, d, a, b, 0xffeff47d, 15)
	b = Step4(b, c, d, a, 0x85845e51, 21)
	a = Step4(a, b, c, d, 0x6fa87e4f, 6)
	d = Step4(d, a, b, c, 0xfe2ce6e0, 10)
	c = Step4(c, d, a, b, 0xa3014314, 15)
	b = Step4(b, c, d, a, 0x4e0811a1, 21)
	a = Step4(a, b, c, d, 0xf7537e82, 6)
	d = Step4(d, a, b, c, 0xbd3af235, 10)
	c = Step4(c, d, a, b, 0x2ad7d2bb, 15)
	b = (Step4(b, c, d, a, 0xeb86d391, 21) + 0xefcdab89) % 0x100000000
	
	c = (c + 0x98badcfe) % 0x100000000
	a = floor(b / 0x10000) % 0x100 + floor(b / 0x1000000) % 0x100 * 0x100 + c % 0x100 * 0x10000 + floor(c / 0x100) % 0x100 * 0x1000000
	
	if (bEnabled) then
		jit.on()
	end
	
	return a
end

function math.PoundsToKilograms( nPounds )
	return nPounds * 0.4535924277
end

function math.KilogramsToPounds( nKilos )
	return nKilos * 2.2046226218488
end