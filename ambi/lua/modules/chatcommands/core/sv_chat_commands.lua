local C = Ambi.Packages.Out( 'colors' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerSay', 'Ambi.ChatCommands.Execute', function( ePly, sText )
    if ( sText[ 1 ] ~= Ambi.ChatCommands.Config.prefix ) then return end

    local tab = string.Explode( ' ', sText )
    local cmd = string.sub( string.lower( tab[ 1 ] ), 2, #tab[ 1 ] )

    local command = Ambi.ChatCommands.cmds[ cmd ]
    if not command then return end

    if timer.Exists( 'AmbiChatCommandDelay:'..cmd..'['..ePly:SteamID()..']' ) then ePly:ChatSend( C.ERROR, '[•] ', C.ABS_WHITE, 'Подождите: ', C.ERROR, tostring( math.floor( timer.TimeLeft( 'AmbiChatCommandDelay:'..cmd..'['..ePly:SteamID()..']' ) + 1 ) ), C.ABS_WHITE, ' секунд' ) return '' end
    timer.Create( 'AmbiChatCommandDelay:'..cmd..'['..ePly:SteamID()..']', command.delay, 1, function() end )

    if ( hook.Call( '[Ambi.ChatCommands.CanExecute]', nil, ePly, command, sText ) == false ) then return end
    
    local result = command.Action( ePly, tab )

    if result or ( Ambi.ChatCommands.Config.show_commands == false ) then return '' end

    hook.Call( '[Ambi.ChatCommands.Executed]', nil, ePly, command, sText )
end )