local AddString = AMB.Ambition.Network.AddString
local Player = FindMetaTable( 'Player' )

-- -------------------------------------------------------------------------------------
local util = util
-- -------------------------------------------------------------------------------------

local net_run_command = AddString( 'amb_player_run_command' )
function Player:RunCommand( sText )
    net.Start( 'amb_player_run_command' )
        net.WriteString( sText or '' )
    net.Send( self )
end

-- -------------------------------------------------------------------------------------

function Player:FreezeMove( bFreeze, nTime )
    self.frozen = bFreeze

    if nTime and isnumber( nTime ) and ( nTime > 0 ) and ( nTime < 268435456 ) then
        timer.Simple( nTime, function()
            if IsValid( self ) then self.frozen = false end
        end )
    end
end

function Player:IsFrozenMove()
    return self.frozen
end

hook.Add( 'SetupMove', 'AMB.Player.PlayerFreezeMove', function( ePly, cmoveInfo, cuserCommand )
    if ePly.frozen and ( cmoveInfo:KeyDown( IN_FORWARD ) or cmoveInfo:KeyDown( IN_MOVELEFT ) or cmoveInfo:KeyDown( IN_MOVERIGHT ) or cmoveInfo:KeyDown( IN_BACK ) ) then  
        cmoveInfo:SetForwardSpeed( 0.00 )
        cmoveInfo:SetSideSpeed( 0.00 )
        cmoveInfo:SetUpSpeed( 0.00 )
    end
end )

-- -------------------------------------------------------------------------------------

