net.Receive( 'ambi_player_run_command', function()
    LocalPlayer():ConCommand( net.ReadString() )
end )

net.Receive( 'ambi_player_open_url', function()
    gui.OpenURL( net.ReadString() )
end )