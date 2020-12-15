AMB = AMB or {}

local sv = include
local cl = AddCSLuaFile

sv( 'main/loader/sh_loader.lua' )
sv( 'main/register.lua' )

cl( 'main/loader/sh_loader.lua' )
cl( 'main/register.lua' )

if CLIENT then

    sv( 'main/loader/sh_loader.lua' )
    sv( 'main/register.lua' )

end