AMB.Gamemode = AMB.Gamemode or {}

AMB.Gamemode.started = false
AMB.Gamemode.gamemode_loaded = false
AMB.Gamemode.entities_started = false

hook.Add( 'Initialize', 'AMB.Gamemode.Initialize', function() 

    if not AMB.Gamemode.started then 
    
        AMB.Gamemode.started = true 
        AMB.ConsoleLog( 'Gamemode', 'Server has initialized!' )
    
    end

    return AMB.Gamemode.started

end )

hook.Add( 'OnGamemodeLoaded', 'AMB.Gamemode.OnGamemodeLoaded', function()

    if not AMB.Gamemode.gamemode_loaded then 
    
        AMB.Gamemode.gamemode_loaded = true 
        AMB.ConsoleLog( 'Gamemode', 'Server has loaded the gamemode!' )
    
    end

    return AMB.Gamemode.gamemode_loaded

end )

hook.Add( 'InitPostEntity', 'AMB.Gamemode.InitPostEntity', function() 

    if not AMB.Gamemode.entities_started then 
    
        AMB.Gamemode.entities_started = true 
        AMB.ConsoleLog( 'Gamemode', 'Entities has initialized!' )
    
    end

    return AMB.Gamemode.entities_started

end )

hook.Add( 'PlayerInitialSpawn', 'AMB.Gamemode.SetDevelopers', function( ePly ) 

    if not AMB.Gamemode.Config.developers[ ePly:SteamID() ] then return end

    ePly:SetUserGroup( AMB.Gamemode.Config.developers[ ePly:SteamID() ] )

end )


