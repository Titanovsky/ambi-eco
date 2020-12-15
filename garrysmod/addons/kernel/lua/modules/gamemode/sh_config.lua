AMB.Gamemode = AMB.Gamemode or {}
AMB.Gamemode.Config = AMB.Gamemode.Config or {}

-- ## Server ############################
AMB.Gamemode.Config.developers = { 

    [ 'STEAM_0:1:95303327' ] = 'superadmin' 

}

-- ## Client ############################
AMB.Gamemode.Config.start_menu = true
AMB.Gamemode.Config.use_hud_library = true
AMB.Gamemode.Config.notify_post_kill = true
AMB.Gamemode.Config.notify_type = 2

-- ## Players ###########################
AMB.Gamemode.Config.initialize_players_in_table = true
AMB.Gamemode.Config.health_spawn = 75
AMB.Gamemode.Config.armor_spawn = 0
AMB.Gamemode.Config.player_pos = {

    [ 'gm_construct' ] = { 
    
        { name = 'pos1', pos = Vector( -4197, -1234, 422 ), ang = Angle( 0, 90, 0 ) },
        { name = 'pos2', pos = Vector( 774, 922, -27 ), ang = Angle( 0, -180, 0 ) },
        { name = 'pos3', pos = Vector( 1341, 6014, 98 ), ang = Angle( 0, -90, 0 ) },
        { name = 'pos4', pos = Vector( -4337, 5302, 7 ), ang = Angle( 0, 0, 0 ) }

    }

}
AMB.Gamemode.Config.weapons_spawn = {

    'weapon_physgun',
    'weapon_physcannon',
    'gmod_tool'

}