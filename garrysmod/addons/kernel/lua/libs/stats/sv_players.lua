AMB.Stats = AMB.Stats or {}
AMB.Stats.Players = AMB.Stats.Players or {}
AMB.Stats.Players.table = AMB.Stats.Players.table or {}

function AMB.Stats.Players.InitializePlayer( ePly )

    if AMB.Stats.Players.table[ ePly:SteamID() ] then ePly.init = true return AMB.Stats.Players.ValidateInitialPlayer( ePly ) end

    AMB.Stats.Players.table[ ePly:SteamID() ] = {

        entity = ePly,
        steamid = ePly:SteamID(),
        steamid64 = ePly:OwnerSteamID64(),
        ip = ePly:IPAddress()

    }

    ePly.init = true

    return AMB.Stats.Players.ValidateInitialPlayer( ePly )

end

function AMB.Stats.Players.ValidateInitialPlayer( ePly )

    if ePly.init then return true end

    return false

end

function AMB.Stats.Players.GetTable()

    return AMB.Stats.Players.table

end

function AMB.Stats.Players.PrintTable()

    PrintTable( AMB.Stats.Players.table )

end