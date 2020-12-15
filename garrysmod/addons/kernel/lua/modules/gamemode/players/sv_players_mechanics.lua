AMB.Gamemode = AMB.Gamemode or {}
local CFG = AMB.Gamemode.Config

hook.Add( 'PlayerInitialSpawn', 'AMB.Gamemode.PlayerInitialSpawn', function( ePly ) 

    if not CFG.initialize_players_in_table then return end

    AMB.Stats.Players.InitializePlayer( ePly )

end )

hook.Add( 'PlayerSpawn', 'AMB.Gamemode.PlayerSpawn', function( ePly ) 

    timer.Simple( 0, function()
    
        AMB.Stats.SetStats( ePly, 'health', CFG.hp_spawn or 100 )
        AMB.Stats.SetStats( ePly, 'armor', CFG.armor_spawn or 0 )

        if CFG.player_pos[ game.GetMap() ] then

            local spawn_list = CFG.player_pos[ game.GetMap() ]
            local rand = math.random( 1, #spawn_list )

            ePly:SetPos( spawn_list[ rand ].pos )
            ePly:SetEyeAngles( spawn_list[ rand ].ang )

        end
    
    end )

end )

hook.Add( 'PlayerLoadout', 'AMB.Gamemode.PlayerLoadout', function( ePly ) 

    if not AMB.Gamemode.Config.weapons_spawn then return true end

    for i = 1, #AMB.Gamemode.Config.weapons_spawn do ePly:Give( AMB.Gamemode.Config.weapons_spawn[ i ] ) end

	return false

end )