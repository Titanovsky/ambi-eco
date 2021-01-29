AMB.Language = AMB.Language or {}
AMB.Language.table = AMB.Language.table or {}

local GetConVar = GetConvar

function AMB.Language.Add( sPattern, tLanguages )

    if not istable( tLanguages ) then AMB.ErrorLog( 'Language', 'The second argument is not a table' ) return end

    AMB.Language.table[ sPattern ] = tLanguages

end

function AMB.Language.Get( sPattern )

    local lang = GetConvar( 'cl_language' ):GetString()

    if not isstring( sPattern ) then sPattern = tostring( sPattern ) end
    if not AMB.Language.table[ sPattern ] then AMB.ErrorLog( 'Language', 'Pattern '..sPattern..' is not valid' ) return '' end
    if not AMB.Language.table[ sPattern ][ lang ] then AMB.ErrorLog( 'Language', 'In pattern '..sPattern..' is not valid language '..lang ) return '' end

    return AMB.Language.table[ sPattern ][ lang ]

end

function AMB.Language.GetTable( sPattern )

    return AMB.Language.table

end