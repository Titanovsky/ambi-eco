local AddString = Ambi.General.Network.AddString
local Player = FindMetaTable( 'Player' )

-- -------------------------------------------------------------------------------------
local net = net
-- -------------------------------------------------------------------------------------

local net_run_command = AddString( 'ambi_player_run_command' )
function Player:RunCommand( sText )
    net.Start( 'ambi_player_run_command' )
        net.WriteString( sText or '' )
    net.Send( self )
end