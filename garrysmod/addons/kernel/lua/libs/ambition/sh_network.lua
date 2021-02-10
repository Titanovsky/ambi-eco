AMB.Network = AMB.Network or {}
AMB.Network.table = AMB.Network.table or {}

local util = util
local net  = net

function AMB.Network.AddString( sName )

    if SERVER then util.AddNetworkString( sName ) end
    AMB.Network.table[ #AMB.Network.table+1 ] = sName

    return sName
    
end
