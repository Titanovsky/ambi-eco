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

function AMB.Utility.GetRussianDate( nDate )

    return os.date( '%d.%m.%Y', nDate )

end

function AMB.Utility.StringIsNullOrWhitespaces( sString )

    if not sString or not isstring( sString ) then return true end

    for _, char in ipairs( string.Explode( '', sString ) ) do

        if ( char ~= ' ' ) then return false end

    end

    return true

end