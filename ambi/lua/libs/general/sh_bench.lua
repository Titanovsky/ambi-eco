Ambi.General.Bench = Ambi.General.Bench or {}

local SysTime, CurTime, ipairs, tostring, MsgC = SysTime, CurTime, ipairs, tostring, MsgC
local hook_Call = hook.Call
local С_WHITE, C_RED, C_GREEN = Color( 0xFA, 0xFA, 0xFA ), Color( 0xFF, 0x0, 0x0 ), Color( 0x0, 0xFF, 0x0 )

-- ----------------------------------------------------------------------------------------------------------
local stack = {}

function Ambi.General.Bench.Push()
	stack[#stack + 1] = SysTime()
end

function Ambi.General.Bench.Pop()
	local ret = stack[#stack]
	stack[#stack] = nil

	return SysTime() - ret
end

function Ambi.General.Bench.Run( fAction, nCalls )
	Ambi.General.Bench.Push()

	nCalls = nCalls or 1024

	for i = 1, nCalls do fAction() end

	return Ambi.General.Bench.Pop()
end

local lowest = math.huge
function Ambi.General.Bench.Compare( tFunctiones, nCalls )
	local results = {}

	for i, Action in ipairs( tFunctiones ) do
		local runtime = Ambi.General.Bench.Run( Action, nCalls )

		results[ i ] = runtime

		if ( runtime < lowest ) then lowest = runtime end
	end

	print( '\n')
	for i, v in ipairs(results) do
		local color = ( v == lowest ) and C_GREEN or C_RED

		MsgC( color, '['..i..'] ', С_WHITE, v..'\n' )
	end
end

-- ----------------------------------------------------------------------------------------------------------
local last_diff = 9999
local delta_diff = 0

function Ambi.General.Bench.CheckLag( nMaxNumLag )
	nMaxNumLag = nMaxNumLag or 0.564

	local sys_diff = SysTime() - CurTime()
	delta_diff = sys_diff - last_diff
	last_diff = sys_diff

	local has_lag = ( delta_diff > nMaxNumLag )

	hook_Call( '[Ambi.General.Bench.CheckedLag]', nil, has_lag, delta_diff, nMaxNumLag, last_diff )

	return has_lag
end