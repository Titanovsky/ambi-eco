local PLAYER = FindMetaTable( 'Player' )

function PLAYER:FreezeMove( bFreeze, nTime )
    self.frozen = bFreeze

    if nTime and isnumber( nTime ) and ( nTime > 0 ) and ( nTime < 268435456 ) then
        timer.Simple( nTime, function()
            if IsValid( self ) then self.frozen = false end
        end )
    end
end

function PLAYER:IsFrozenMove()
    return self.frozen
end

hook.Add( 'SetupMove', 'Ambi.PlayerFreeze.StopMove', function( ePly, cmoveInfo, cuserCommand )
    if ( Ambi.PlayerFreeze.enable == false ) then return end

    if ePly.frozen and ( cmoveInfo:KeyDown( IN_FORWARD ) or cmoveInfo:KeyDown( IN_MOVELEFT ) or cmoveInfo:KeyDown( IN_MOVERIGHT ) or cmoveInfo:KeyDown( IN_BACK ) ) then  
        cmoveInfo:SetForwardSpeed( 0.00 )
        cmoveInfo:SetSideSpeed( 0.00 )
        cmoveInfo:SetUpSpeed( 0.00 )
    end
end )