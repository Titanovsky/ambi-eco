Ambi.Configurator.changed_tables = Ambi.Configurator.changed_tables or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
net.AddString( 'ambi_configurator_send_changed_table_to_player' )

net.AddString( 'ambi_configurator_change_table' )
net.Receive( 'ambi_configurator_change_table', function( _, ePly ) 
    if not Ambi.Configurator.Config.allowed_ranks[ ePly:GetUserGroup() ] then ePly:Kick( '[Configurator] Player try to change config without access. Maybe CHEATS!' ) return end

    local name_module = net.ReadString()
    local changed_table = net.ReadTable()

    for key, value in pairs( changed_table ) do
        if Ambi[ name_module ].Config[ key ] then Ambi[ name_module ].Config[ key ] = value end
    end

    Ambi.Configurator.changed_tables[ name_module ] = changed_table

    print( '[Configurator] Admin '..ePly:Nick()..' ('..ePly:SteamID()..') changed the config '..name_module )
    ePly:ChatSend( '~BLUE~ [Configurator] ~WHITE~ #configurator_successful_change ~WHITE~ '..name_module )

    net.Start( 'ambi_configurator_send_changed_table_to_player' )
        net.WriteString( name_module )
        net.WriteTable( changed_table )
    net.Broadcast()

    print( '[Configurator] The changed config '..name_module..' sends to everyone' )
end )

-- ---------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Configurator.CompatibilityChangedTables', function( ePly ) 
    for module, tab in pairs( Ambi.Configurator.changed_tables ) do
        net.Start( 'ambi_configurator_send_changed_table_to_player' )
            net.WriteString( module )
            net.WriteTable( tab )
        net.Send( ePly )
    end
end )