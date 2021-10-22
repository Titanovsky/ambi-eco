local AddString = Ambi.General.Network.AddString
local Player = FindMetaTable( 'Player' )

-- -------------------------------------------------------------------------------------
local net = net
-- -------------------------------------------------------------------------------------

local net_str = AddString( 'ambi_player_run_command' )
function Player:RunCommand( sText )
    net.Start( net_str )
        net.WriteString( sText or '' )
    net.Send( self )
end

local net_str = AddString( 'ambi_player_open_url' )
function Player:OpenURL( sURL )
    net.Start( net_str )
        net.WriteString( sURL or '' )
    net.Send( self )
end