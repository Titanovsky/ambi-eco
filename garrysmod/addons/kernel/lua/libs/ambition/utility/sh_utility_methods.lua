AMB.Utility = AMB.Utility or {}

function AMB.Utility.FindPlayerOnData( sArg, fData, bOnlyHumans )

    if not sData then AMB.ErrorLog( 'Ambition.Utility', 'Not specified fData' ) return false end
    sArg = sArg or ''

    local players = {}
    local find_tbl = bOnlyHumans and player.GetHumans() or player.GetAll()

    for _, ply in pairs( find_tbl ) do

        local data = fData( ply )

        sArg = string.lower( sArg )
        data = string.lower( data )
            
        if string.find( data, sArg ) then table.insert( players, ply ) end
        if ( data == sArg ) then return ply end

    end

    if ( #players == 0 ) or ( #players > 1 ) then return false end

    return players[ 1 ]

end