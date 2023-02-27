Ambi.UI.Notify = Ambi.UI.Notify or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
local Gen, Net = Ambi.General, Ambi.Ambition.Network

local IsValid, istable, isnumber, net, FindMetaTable = IsValid, istable, isnumber, net, FindMetaTable

local DEFAULT_ID = 1

--------------------------------------------------------------------------
local net_str = Net.AddString( 'ambi_ui_notify_draw' )
function Ambi.UI.Notify.Draw( ePly, nID, tOptions )
    if not tOptions or not istable( tOptions ) then Gen.Error( 'UI.Notify.Draw', 'tOptions is not valid' ) return end
    if not IsValid( ePly ) or not ePly:IsPlayer() then Gen.Error( 'UI.Notify.Draw', 'ePly is not valid' ) return end

    net.Start( net_str )
        net.WriteUInt( nID or DEFAULT_ID, 16 )
        net.WriteTable( tOptions )
    net.Send( ePly )
end

function Ambi.UI.Notify.DrawAll( nID, tOptions )
    if not tOptions or not istable( tOptions ) then Gen.Error( 'UI.Notify.DrawAll', 'Not valid tOptions' ) return end

    net.Start( net_str )
        net.WriteUInt( nID or DEFAULT_ID, 16 )
        net.WriteTable( tOptions )
    net.Broadcast()
end

local net_str = Net.AddString( 'ambi_ui_notify_simple_draw' )
function Ambi.UI.Notify.SimpleDraw( ePly, nID, ... )
    if not IsValid( ePly ) or not ePly:IsPlayer() then Gen.Error( 'UI.Notify.Draw', 'ePly is not valid' ) return end

    local values = { ... }
    if not values then Gen.Error( 'UI.Notify.SimpleDraw', 'Not valid values' ) return end

    net.Start( net_str )
        net.WriteUInt( nID or DEFAULT_ID, 16 )
        net.WriteTable( values )
    net.Send( ePly )
end

function Ambi.UI.Notify.SimpleDrawAll( nID, ... )
    if not IsValid( ePly ) or not ePly:IsPlayer() then Gen.Error( 'UI.Notify.Draw', 'ePly is not valid' ) return end

    local values = { ... }
    if not values then Gen.Error( 'UI.Notify.SimpleDraw', 'Not valid values' ) return end

    net.Start( net_str )
        net.WriteUInt( nID or DEFAULT_ID, 16 )
        net.WriteTable( values )
    net.Broadcast()
end

--------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:NotifySend( nID, tOptions )
    Ambi.UI.Notify.Draw( self, nID, tOptions )
end

function PLAYER:NotifySimpleSend( nID, ... )
    Ambi.UI.Notify.SimpleDraw( self, nID, ... )
end

function PLAYER:NotifyDraw( nID, tOptions ) 
    self:NotifySend( nID, tOptions ) 
end

function PLAYER:NotifySimpleDraw( nID, ... ) 
    self:NotifySimpleSend( nID, ... ) 
end