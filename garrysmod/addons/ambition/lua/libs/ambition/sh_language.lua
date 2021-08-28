AMB.Ambition.Language = AMB.Ambition.Language or {}

local istable, GetConVarString, tostring, isstring = istable, GetConVarString, tostring, isstring

local phrases = {}

function AMB.Ambition.Language.Add( sPattern, tLanguages )
    if not tLanguages or istable( tLanguages ) then return end
    if not sPattern or isstring( sPattern ) then return end

    phrases[ sPattern ] = tLanguages

    return AMB.Ambition.Language.Get( sPattern )
end

function AMB.Ambition.Language.Get( sPattern )
    local lang = SERVER and AMB.Config.language or GetConVarString( 'gmod_language' )

    sPattern = tostring( sPattern )
    if not phrases[ sPattern ] then return '' end
    if not phrases[ sPattern ][ lang ] then return '' end

    return AMB.Language.table[ sPattern ][ lang ]
end

function AMB.Ambition.Language.AddBetweenRussianAndEnglish( sPattern, sRussian, sEnglish )
    sRussian = sRussian or ''
    sEnglish = sEnglish or sRussian

    phrases[ sPattern ] = { ru = sRussian, en = sEnglish }

    return AMB.Language.Get( sPattern )
end

function AMB.Ambition.Language.GetPhrases()
    return phrases
end