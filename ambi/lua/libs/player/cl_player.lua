net.Receive( 'ambi_player_run_command', function()
    LocalPlayer():ConCommand( net.ReadString() or '' )
end )

net.Receive( 'ambi_player_open_url', function()
    gui.OpenURL( net.ReadString() or '' )
end )

net.Receive( 'ambi_player_set_clipboard_text', function()
    SetClipboardText( net.ReadString() or '' )
end )