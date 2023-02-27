local C = Ambi.General.Global.Colors
local Add = Ambi.ChatCommands.Add
local AddAlter = Ambi.ChatCommands.AddAlternative
local TYPE = 'Main'

-- ---------------------------------------------------------------------------------------------------------------------------------------
Add( 'cmd', TYPE, 'Показать все команды.', 1, function( ePly, tArgs ) 
    ePly:ChatSend( C.AMBI, '----------------------------' )
    for cmd, tab in SortedPairsByMemberValue( Ambi.ChatCommands.cmds, 'type' ) do 
        if tab.is_hidden then continue end
        
        ePly:ChatSend( C.FLAT_BLUE, cmd, C.AMBI_WHITE, ' — '..tab.desc  ) 
    end
    ePly:ChatSend( C.AMBI, '----------------------------' )
end )
AddAlter( 'cmds', 'cmd' )
AddAlter( 'commands', 'cmd' )