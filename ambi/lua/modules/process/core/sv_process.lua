local AddString = Ambi.General.Network.AddString
local PLAYER = FindMetaTable( 'Player' )

local net_start = AddString( 'ambi_process_start' )
function PLAYER:RunProcess( sName, sDescription, nTime, nFreeze, fAction )
    if not self:Alive() then return end
    if ( self.IsFrozenMove and self:IsFrozenMove() ) or self:IsFrozen() then return end
    if self.process then return end

    nTime = nTime or 0.1
    nFreeze = nFreeze or 0

    net.Start( net_start )
        net.WriteString( sName )
        net.WriteString( sDescription or '' )
        net.WriteFloat( nTime )
    net.Send( self )
    
    self.process = sName
    self.process_freeze = nFreeze

    if nFreeze then
        if ( nFreeze == 1 ) then self:FreezeMove( true )
        elseif ( nFreeze == 2 ) then self:Freeze( true )
        end
    end
    
    timer.Create( 'AmbiProcess:'..tostring( self )..':'..sName, nTime, 1, function()
        if not IsValid( self ) then return end

        self.process = false
        if fAction then fAction( self ) end

        if nFreeze then
            if ( nFreeze == 1 ) then self:FreezeMove( false )
            elseif ( nFreeze == 2 ) then self:Freeze( false )
            end
        end
    end )
end

hook.Add( 'PlayerDisconnected', 'Ambi.Process.RemoveTimer', function( ePly )
    local process = ePly:GetProcess()
    if not process then return end

    timer.Remove( 'AmbiProcess:'..tostring( ePly )..':'..process )
end )

AddString( 'ambi_process_stop' )
hook.Add( 'PlayerDeath', 'Ambi.Process.Break', function( ePly )
    if ePly:IsProcess() then
        timer.Remove( 'AmbiProcess:'..tostring( ePly )..':'..ePly:GetProcess() )
        ePly.process = false
        
        net.Start( 'ambi_process_stop' )
        net.Send( ePly )
    end
end )

local net_break = AddString( 'ambi_process_break' )
net.Receive( net_break, function( nLen, ePly )
    local process = ePly:GetProcess()
    if not process then return end

    if ( ePly.process_freeze == 1 ) then ePly:FreezeMove( false )
    elseif ( ePly.process_freeze == 2 ) then ePly:Freeze( false ) 
    end
    
    timer.Remove( 'AmbiProcess:'..tostring( ePly )..':'..process )
    ePly.process = false
end )