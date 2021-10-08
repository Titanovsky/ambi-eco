Ambi.Timer = AMB.Timer or {}
setmetatable( Ambi.Timer, { __index = timer } )

--[[
    !!! DON'T UPDATE THIS FILE !!!
    This is I used replace original methods, because it file need updating only one time!
    If a file updated, when reset all methods, which used here!
]]--

-- -------------------------------------------------------------------------------------
local timer_create, timer_remove = timer.Create, timer.Remove
-- -------------------------------------------------------------------------------------

function timer.Create( sID, nDelay, nRep, fCallback )
    timer_create( sID, nDelay, nRep, fCallback )

    hook.Call( '[Ambi.Timer.Create]', nil, sID, nDelay, nRep, fCallback )
end 

function timer.Remove( sID )
    timer_remove( sID )

    hook.Call( '[Ambi.Timer.Remove]', nil, sID )
end 