AMB.UI = AMB.UI or {}
AMB.UI.Sounds = AMB.UI.Sounds or {}
AMB.UI.Sounds.table = AMB.UI.Sounds.table or {}

local surface = surface
local util = util

function AMB.UI.Sounds.CreateSound( sName, sPath )

    AMB.UI.Sounds.table[ sName ] = {

	    sound = sPath,

    }

    return sPath

end

function AMB.UI.Sounds.GetTable()

    return AMB.UI.Sounds.table

end

function AMB.UI.Sounds.PrintTable()

    PrintTable( AMB.UI.Sounds.table )

    return true

end

function AMB.UI.Sounds.PlaySound( sName )

    if AMB.UI.Sounds.table[ sName ] then surface.PlaySound( AMB.UI.Sounds.table[ sName ].sound ) return end

    surface.PlaySound( sName )

end

local function ReceivePlaySound( nLen )

    local str = net.ReadString()

    AMB.UI.Sounds.PlaySound( str )

end
net.Receive( 'ambSoundPlay', ReceivePlaySound )
