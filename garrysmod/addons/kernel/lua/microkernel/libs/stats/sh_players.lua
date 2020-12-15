AMB.Stats = AMB.Stats or {}
AMB.Stats.Players = AMB.Stats.Players or {}
AMB.Stats.Players.table = AMB.Stats.Players.table or {}

function AMB.Stats.Online( bPlayer )

    if bPlayer then return #player.GetHumans() end

    return #player.GetAll()

end

function AMB.Stats.GetPlayerID( nID )

    local ent = Entity( nID )

    if not IsValid( ent ) then AMB.ErrorLog( 'Stats', ' Entity ID '..nID..' is not exists' ) return false end

    if not ent:IsPlayer() then AMB.ErrorLog( 'Stats', 'Entity ID '..nID..' it is not Player' ) return false end
    
    return ent

end