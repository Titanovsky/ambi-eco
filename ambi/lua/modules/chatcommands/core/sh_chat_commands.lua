local Error, Warning = Ambi.General.Error, Ambi.General.Warning

Ambi.ChatCommands.cmds = Ambi.ChatCommands.cmds or {}

function Ambi.ChatCommands.Add( sName, sType, sDescription, nDelay, fAction, bHidden )
    if not fAction then Error( 'ChatCommands', 'fAction for AddCommand not found' ) return end

    if not sName or not isstring( sName ) then Warning( 'ChatCommands', 'sName for AddCommand not found, now sName = "test"' ) end
    sName = tostring( sName ) or 'test'

    if not nDelay then Warning( 'ChatCommands', 'nDelay for AddCommand not found, now nDelay = 1' ) end
    nDelay = nDelay or 1

    if ( hook.Call( '[Ambi.ChatCommands.CanAdd]', nil, sName, sType, sDescription, nDelay, fAction, bHidden ) == false ) then return end

    Ambi.ChatCommands.cmds[ sName ] = {
        type = sType or 'Other',
        desc = sDescription or '',
        delay = nDelay,
        is_hidden = bHidden,
        Action = fAction
    }
    
    if SERVER then print( '[ChatCommands] Added command /'..sName ) end

    hook.Call( '[Ambi.ChatCommands.Added]', nil, sName, sType, sDescription, nDelay, fAction, bHidden )
end
Ambi.ChatCommands.AddCommand = Ambi.ChatCommands.Add -- for compatibility

function Ambi.ChatCommands.AddAlternative( sName, sOriginallyCommand )
    if Ambi.ChatCommands.cmds[ sName ] then return end

    local original_cmd = Ambi.ChatCommands.cmds[ sOriginallyCommand ]
    if not original_cmd then return end

    Ambi.ChatCommands.Add( sName, original_cmd.type, original_cmd.desc, original_cmd.delay, original_cmd.Action, true )
end

function Ambi.ChatCommands.Remove( sName )
    if not sName then return end
    if ( hook.Call( '[Ambi.ChatCommands.CanRemove]', nil, sName ) == false ) then return end
    
    local old_tab = Ambi.ChatCommands.cmds[ sName ]

    Ambi.ChatCommands.cmds[ sName ] = nil

    hook.Call( '[Ambi.ChatCommands.Removed]', nil, sName, old_tab )
end