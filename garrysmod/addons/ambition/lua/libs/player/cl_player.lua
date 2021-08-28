net.Receive( 'amb_player_run_command', function()
    LocalPlayer():ConCommand( net.ReadString() )
end )