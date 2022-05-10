local Error, Warning = Ambi.General.Error, Ambi.General.Warning

Ambi.ChatCommands.cmds = Ambi.ChatCommands.cmds or {}

function Ambi.ChatCommands.AddCommand( sName, sType, sDescription, nDelay, fAction, bSendInChat )
    if not fAction then Error( 'ChatCommands', 'fAction for AddCommand not found' ) return end

    if not sName or not isstring( sName ) then Warning( 'ChatCommands', 'sName for AddCommand not found, now sName = "test"' ) end
    sName = tostring( sName ) or 'test'

    if not nDelay then Warning( 'ChatCommands', 'nDelay for AddCommand not found, now nDelay = 1' ) end
    nDelay = nDelay or 1

    Ambi.ChatCommands.cmds[ sName ] = {
        type = sType or 'Other',
        desc = sDescription or '',
        delay = nDelay,
        send_in_chat = bSendInChat,
        Action = fAction
    }

    hook.Call( '[Ambi.ChatCommands.AddedCommand]', nil, sName, sType, sDescription, nDelay, fAction, bSendInChat )
end

function Ambi.ChatCommands.RemoveCommand( sName )
    if not sName then return end
    
    local old_tab = Ambi.ChatCommands.cmds[ sName ]

    Ambi.ChatCommands.cmds[ sName ] = nil

    hook.Call( '[Ambi.ChatCommands.RemovedCommand]', nil, sName, old_tab )
end