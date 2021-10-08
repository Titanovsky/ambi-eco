net.Receive( 'ambi_player_run_command', function()
    LocalPlayer():ConCommand( net.ReadString() )
end )