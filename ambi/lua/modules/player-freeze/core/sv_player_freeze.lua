local PLAYER = FindMetaTable( 'Player' )

function PLAYER:FreezeMove( bFreeze, nTime )
    self.frozen = bFreeze

    if not nTime then return end

    timer.Simple( nTime, function()
        if IsValid( self ) then self.frozen = false end
    end )
end

function PLAYER:IsFrozenMove()
    return self.frozen
end

hook.Add( 'SetupMove', 'Ambi.PlayerFreeze.StopMove', function( ePly, cmoveInfo, cuserCommand )
    if not Ambi.PlayerFreeze.enable then return end
    if not ePly:IsFrozenMove() then return end

    cmoveInfo:SetForwardSpeed( 0.00 )
    cmoveInfo:SetSideSpeed( 0.00 )
    cmoveInfo:SetUpSpeed( 0.00 )
end )