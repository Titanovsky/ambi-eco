AMB.UI.Notify = AMB.UI.Notify or {}

local A, Net = AMB.Ambition, AMB.Ambition.Network
local IsValid, istable, isnumber, net, FindMetaTable = IsValid, istable, isnumber, net, FindMetaTable

local str = Net.AddString( 'amb_ui_notify_draw' )
function AMB.UI.Notify.Draw( ePly, nID, tOptions )
    if not nID then return end
    if not tOptions or not istable( tOptions ) then A.Error( 'UI', 'Notify.Draw: tOptions' ) return end
    if not IsValid( ePly ) or not ePly:IsPlayer() then return end

    net.Start( str )
        net.WriteUInt( nID or 1, 6 )
        net.WriteTable( tOptions )
    net.Send( ePly )
end

function AMB.UI.Notify.DrawAll( nID, tOptions )
    if not nID then return end
    if not tOptions or not istable( tOptions ) then A.Error( 'UI', 'Notify.Draw: tOptions' ) return end

    net.Start( str )
        net.WriteUInt( nID or 1, 6 )
        net.WriteTable( tOptions )
    net.Broadcast()
end

local Player = FindMetaTable( 'Player' )

function Player:NotifySend( nID, tOptions )
    AMB.UI.Notify.Draw( self, nID, tOptions )
end

-- Compability --
AMB.UI.Notify.DrawNotify = AMB.UI.Notify.Draw