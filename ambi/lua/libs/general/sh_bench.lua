Ambi.General.Bench = Ambi.General.Bench or {}

-- -------------------------------------------------------------------------------------
local SysTime 	= SysTime
local pairs 	= pairs
local tostring 	= tostring
local MsgC 		= MsgC
-- -------------------------------------------------------------------------------------

local С_WHITE, C_RED, C_GREEN = Color( 0xFA, 0xFA, 0xFA ), Color( 0xFF, 0x0, 0x0 ), Color( 0x0, 0xFF, 0 )

local stack = {}
function Ambi.General.Bench.Push()
	stack[#stack + 1] = SysTime()
end

function Ambi.General.Bench.Pop()
	local ret = stack[#stack]
	stack[#stack] = nil
	return SysTime() - ret
end

function Ambi.General.Bench.Run(func, calls)
	Ambi.General.Bench.Push()
	for i = 1, (calls or 1000) do
		func()
	end
	return Ambi.General.Bench.Pop()
end

function Ambi.General.Bench.Compare(funcs, calls)
	local lowest = math.huge
	local results = {}
	for k, v in pairs(funcs) do
		local runtime = Ambi.General.Bench.Run(v, calls)
		results[k] = runtime
		if (runtime < lowest) then
			lowest = runtime
		end
	end
	for k, v in pairs(results) do
		if (v == lowest) then
			MsgC( C_GREEN, tostring(k):upper() .. ': ', С_WHITE, v .. '\n')
		else
			MsgC( C_RED, tostring(k):upper() .. ': ', С_WHITE, v .. '\n')
		end
	end
end
