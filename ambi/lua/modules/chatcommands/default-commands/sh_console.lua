local Add = Ambi.ChatCommands.AddCommand
local TYPE = 'Console'

Add( 'retry', TYPE, 'Перезайти на сервер.', 1.5, function( ePly, tArgs ) 
    ePly:RunCommand( 'retry' )
end )

Add( 'stopsound', TYPE, 'Остановить все звуки.', 1.5, function( ePly, tArgs ) 
    ePly:RunCommand( 'stopsound' )
end )

Add( 'skybox', TYPE, 'Вкл/Выкл Skybox', 1.5, function( ePly, tArgs ) 
    local value = tostring( tArgs[ 2 ] )

    ePly:RunCommand( 'r_3dsky '..value )
end )

Add( 'decals', TYPE, 'Очистить декали', 1.5, function( ePly, tArgs ) 
    ePly:RunCommand( 'r_cleardecals' )
end )