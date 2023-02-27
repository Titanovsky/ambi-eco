local Add = Ambi.ChatCommands.Add
local TYPE = 'URLs'

-- ---------------------------------------------------------------------------------------------------------------------------------------
Add( 'content', TYPE, 'Открыть ссылку на контент.', 1, function( ePly, tArgs ) 
    ePly:OpenURL( Ambi.ChatCommands.Config.url_content )
end )

Add( 'steam', TYPE, 'Открыть ссылку на Steam группу.', 1, function( ePly, tArgs ) 
    ePly:OpenURL( Ambi.ChatCommands.Config.url_steam )
end )

Add( 'discord', TYPE, 'Открыть ссылку на Дискорд.', 1, function( ePly, tArgs ) 
    ePly:OpenURL( Ambi.ChatCommands.Config.url_discord )
end )

Add( 'vk', TYPE, 'Открыть ссылку на VK группу.', 1, function( ePly, tArgs ) 
    ePly:OpenURL( Ambi.ChatCommands.Config.url_vk )
end )