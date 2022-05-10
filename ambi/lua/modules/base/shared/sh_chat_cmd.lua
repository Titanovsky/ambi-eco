if not Ambi.ChatCommands then Ambi.General.Error( 'DarkRP', 'Before Base module, need to connect ChatCommands module' ) return end

local Add = Ambi.ChatCommands.AddCommand
local C = Ambi.Packages.Out( 'colors' )
local TYPE = 'Base'

Add( 'hud', TYPE, 'Сменить худ', 0.25, function( ePly, tArgs ) 
    if not Ambi.Base.Config.hud_enable then return end

    net.Start( 'ambi_base_change_hud' )
        net.WriteString( tArgs[ 2 ] )
    net.Send( ePly )

    return true
end )

Add( 'huds', TYPE, 'Вывести список всех худов', 1, function( ePly, tArgs ) 
    if not Ambi.Base.Config.hud_enable then return end

    net.Start( 'ambi_base_show_huds' )
    net.Send( ePly )

    return true
end )

if CLIENT then
    net.Receive( 'ambi_base_change_hud', function() 
        local arg = net.ReadString()
        if not string.IsValid( arg ) then chat.AddText( C.ERROR, 'Напишите ID худа!' ) return end
        
        local hud = Ambi.Base.GetHUD( tonumber( arg ) )
        if not hud then chat.AddText( C.ERROR, 'Такого худа не существует! Посмотрите в /huds' ) return end

        Ambi.Base.SetHUD( tonumber( arg ) )
        chat.AddText( C.UK_DARK_GREEN, '[BASE] ', C.ABS_WHITE, 'Вы поставили худ ', C.UK_DARK_GREEN, hud.name )
    end )

    net.Receive( 'ambi_base_show_huds', function() 
        for id, hud in pairs( Ambi.Base.GetAllHUD() ) do
            chat.AddText( C.UK_DARK_GREEN, id..'. ', C.ABS_WHITE, hud.name )
        end
    end )
else
    net.AddString( 'ambi_base_change_hud' )
    net.AddString( 'ambi_base_show_huds' )
end