Ambi.General.Utility.Random = Ambi.General.Utility.Random or {}
util.Random = util.Random or {}
setmetatable( Ambi.General.Utility.Random, { __index = util.Random } )

-- -------------------------------------------------------------------------------------
local math, string, os = math, string, os
local Random, Upper, Log, Sqrt, Floor = math.random, string.upper, math.log, math.sqrt, math.floor
local chars = 'qwertyuiopasdfghjklzxcvbnm1234567890'
-- -------------------------------------------------------------------------------------

local MAX = 32
function util.Random.SuperString()
    local super_string = ''

    for i = 1, MAX do 
        local char = chars[ Random( 1, #chars ) ]
        char = ( Random( 0, 1 ) == 1 ) and Upper( char ) or char
        char = ( Random( 1, 4 ) == 4 ) and chars[ Random( 1, #chars ) ] or char

        super_string = super_string..char
    end

    return super_string
end

---------------------------------------------------------------------------------------------------------------------
-- Source: https://github.com/Kefta/Lua-MINSTD/blob/7868b05ab35a090ff9c9eadde8f7fcf2629da2eb/minstd.lua
-- Author: Kefta
util.Random.MinSTD = util.Random.MinSTD or {}
util.Random.MinSTD = {
    m_idum = 0,
	m_iy = 0,
	m_iv = {},
	m_bTimeSeeded = false,
	m_bHaveValue = false,
	m_flRandomValue = 0
}

local NTAB = 32
local IA = 16807
local IM = 2147483647
local IQ = 127773
local IR = 2836
local NDIV = Floor( 1 + ( IM - 1 ) / NTAB )
local MAX_RANDOM_RANGE = 0x7FFFFFFF
local AM = 1/IM
local EPS = 1.2e-7
local RNMX = 1-EPS

function util.Random.MinSTD.SetSeed( iSeed )
    util.Random.MinSTD.m_bTimeSeeded = false
	util.Random.MinSTD.m_idum = iSeed < 0 and iSeed or -iSeed
	util.Random.MinSTD.m_iy = 0
end

function util.Random.MinSTD.SetTimeSeed( iSeed )
	util.Random.MinSTD.m_bTimeSeeded = true
	
	if ( iSeed == 0 ) then
		idum = os.time()
	else
		idum = iSeed > 1000 and -iSeed or iSeed > -1000 and iSeed - 22261048 or iSeed
	end
end

-- Modified Lehmer random number generator
-- Returns integer [1, 2147483647)
function util.Random.MinSTD.RandomNumber()
	local j = 0
	local k = 0
	
	if ( util.Random.MinSTD.m_idum <= 0 or util.Random.MinSTD.m_iy == 0 ) then
		if ( -util.Random.MinSTD.m_idum < 1 ) then
			util.Random.MinSTD.m_idum = 1
		else
			util.Random.MinSTD.m_idum = -util.Random.MinSTD.m_idum
		end
			
		for j= NTAB + 8, 1, -1 do
			k = Floor( util.Random.MinSTD.m_idum / IQ )
			util.Random.MinSTD.m_idum = IA * ( util.Random.MinSTD.m_idum - k * IQ ) - IR * k

			if ( util.Random.MinSTD.m_idum < 0 ) then
				util.Random.MinSTD.m_idum = util.Random.MinSTD.m_idum+IM
			end

			if ( j <= NTAB ) then
				util.Random.MinSTD.m_iv[j] = util.Random.MinSTD.m_idum
			end
		end

		util.Random.MinSTD.m_iy = util.Random.MinSTD.m_iv[1]
	end

	k = Floor( util.Random.MinSTD.m_idum / IQ )
	util.Random.MinSTD.m_idum = IA * ( util.Random.MinSTD.m_idum - k * IQ ) - IR * k

	if ( util.Random.MinSTD.m_idum < 0 ) then
		util.Random.MinSTD.m_idum = util.Random.MinSTD.m_idum + IM
	end

	j = Floor( util.Random.MinSTD.m_iy / NDIV )
	util.Random.MinSTD.m_iy = util.Random.MinSTD.m_iv[ j + 1 ]
	util.Random.MinSTD.m_iv[ j + 1 ] = util.Random.MinSTD.m_idum

	return util.Random.MinSTD.m_iy
end

-- Returns float [flLow, flHigh)
function util.Random.MinSTD.RandomFloat( flLow, flHigh )
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then util.Random.MinSTD.SetTimeSeed( 0 ) end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	-- float in [0,1)
	local fl = AM * util.Random.MinSTD.RandomNumber()
	
	-- Obey Source float limits
	if (fl > RNMX) then fl = RNMX
	elseif (fl < EPS) then fl = 0
	end
	
	return fl * ( ( flHigh or 1 ) - flLow ) + flLow
end

function util.Random.MinSTD.RandomFloatExp( flLow, flHigh, flExponent )
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then
		util.Random.MinSTD.SetTimeSeed( 0 )
	end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	local fl = AM * util.Random.MinSTD.RandomNumber()
	
	if ( fl > RNMX ) then fl = RNMX
	elseif ( fl < EPS ) then fl = 0 end
	
	return fl ^ ( flExponent or 1 ) * ( ( flHigh or 1 ) - flLow ) + flLow
end

-- Returns double [flLow, flHigh)
function util.Random.MinSTD.RandomDouble( flLow, flHigh )
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then util.Random.MinSTD.SetTimeSeed(0) end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	-- double in [1/IM, 1)
	-- MINSTD is not widely distributed enough to go past double limits
	-- So we have to set the min value to 0
	local fl = AM * util.Random.MinSTD.RandomNumber()
	
	if ( fl == AM ) then fl = 0 end
	
	return fl * ( ( flHigh or 1 ) - flLow ) + flLow -- float in [low,high)
end

-- Returns double [flLow, flHigh)
function util.Random.MinSTD.RandomDoubleExp( flLow, flHigh, flExponent )
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then util.Random.MinSTD.SetTimeSeed( 0 ) end
	
	if ( not flLow ) then flLow = 0 end
	
	local fl = AM * util.Random.MinSTD.RandomNumber()
	
	if ( fl == AM ) then fl = 0 end
	
	return fl ^ ( flExponent or 1 ) * ( ( flHigh or 1 ) - flLow ) + flLow
end

-- Returns integer [iLow, iHigh]
function util.Random.MinSTD.RandomInt( iLow, iHigh )
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then util.Random.MinSTD.SetTimeSeed( 0 ) end
	
	--assert(lLow <= lHigh)
	if ( not flLow ) then flLow = 0 end
	
	local x = ( iHigh or 1 ) - iLow + 1
	
	if ( x <= 1 or MAX_RANDOM_RANGE < x-1 ) then return iLow end

	-- The following maps a uniform distribution on the interval [0,MAX_RANDOM_RANGE]
	-- to a smaller, client-specified range of [0,x-1] in a way that doesn't bias
	-- the uniform distribution unfavorably. Even for a worst case x, the loop is
	-- guaranteed to be taken no more than half the time, so for that worst case x,
	-- the average number of times through the loop is 2. For cases where x is
	-- much smaller than MAX_RANDOM_RANGE, the average number of times through the
	-- loop is very close to 1.
	local iMaxAcceptable = MAX_RANDOM_RANGE - ( MAX_RANDOM_RANGE + 1 ) % x 
	local n
	
	repeat
		n = util.Random.MinSTD.RandomNumber()
	until ( n <= iMaxAcceptable )

	return iLow + n % x
end

function util.Random.MinSTD.RandomGaussianFloat( flMean, flStdDev )
	if util.Random.MinSTD.m_bHaveValue then
		util.Random.MinSTD.m_bHaveValue = false
		
		return ( flStdDev or 1 ) * util.Random.MinSTD.m_flRandomValue + ( flMean or 0 )
	end
	
	if ( util.Random.MinSTD.m_bTimeSeeded and util.Random.MinSTD.m_idum == 0 ) then util.Random.MinSTD.SetTimeSeed( 0 ) end
	
	-- Pick 2 random #s from -1 to 1
	-- Make sure they lie inside the unit circle. If they don't, try again
	local v1
	local v2
	local rsq
	
	repeat
		v1 = 2 * util.Random.MinSTD.RandomFloat() - 1
		v2 = 2 * util.Random.MinSTD.RandomFloat() - 1
		rsq = v1 * v1 + v2 * v2
	until ( rsq <= 1 and rsq ~= 0 )
	
	-- The box-muller transformation to get the two gaussian numbers
	local fac = Sqrt( -2 * Log( rsq ) / rsq )
	
	-- Store off one value for later use
	util.Random.MinSTD.m_flRandomValue = v1 * fac
	util.Random.MinSTD.m_bHaveValue = true
	
	return ( flStdDev or 1 ) * ( v2 * fac ) + ( flMean or 0 )
end