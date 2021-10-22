Ambi.UI.Notify = Ambi.UI.Notify or {}

local Gen, Net = Ambi.General, Ambi.Ambition.Network
local IsValid, istable, isnumber, net, FindMetaTable = IsValid, istable, isnumber, net, FindMetaTable

--------------------------------------------------------------------------
local str = Net.AddString( 'ambi_ui_notify_draw' )
function Ambi.UI.Notify.Draw( ePly, nID, tOptions )
    if not tOptions or not istable( tOptions ) then Gen.Error( 'UI', 'Notify.Draw: tOptions' ) return end
    if not IsValid( ePly ) or not ePly:IsPlayer() then return end

    net.Start( str )
        net.WriteUInt( nID or 1, 16 )
        net.WriteTable( tOptions )
    net.Send( ePly )
end

function Ambi.UI.Notify.DrawAll( nID, tOptions )
    if not tOptions or not istable( tOptions ) then Gen.Error( 'UI', 'Notify.Draw: tOptions' ) return end

    net.Start( str )
        net.WriteUInt( nID or 1, 16 )
        net.WriteTable( tOptions )
    net.Broadcast()
end

--------------------------------------------------------------------------
local PLAYER = FindMetaTable( 'Player' )

function PLAYER:NotifySend( nID, tOptions )
    Ambi.UI.Notify.Draw( self, nID or 1, tOptions )
end