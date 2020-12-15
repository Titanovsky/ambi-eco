AMB.Gamemode = AMB.Gamemode or {}
local CFG = AMB.Gamemode.Config

AMB.Stats.RegStats( 'GameName', 'string' )

hook.Add( 'PlayerInitialSpawn', 'AMB.Gamemode.SetupGameNameForPlayers', function( ePly ) 

    timer.Simple( 0, function()
    
        AMB.Stats.SetStats( ePly, 'GameName', ePly:Nick() )
    
    end )

end )
