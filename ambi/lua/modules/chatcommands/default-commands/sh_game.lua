local C = Ambi.General.Global.Colors
local Add = Ambi.ChatCommands.Add
local TYPE = 'Game'

-- ---------------------------------------------------------------------------------------------------------------------------------------
Add( 'ip', TYPE, 'Узнать IP адрес сервера', 1, function( ePly, tArgs ) 
    ePly:ChatSend( C.AMBI, '>> ', C.FLAT_BLUE, game.GetIPAddress() )
    ePly:SetClipboardText( game.GetIPAddress() )
end )