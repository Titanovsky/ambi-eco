AMB.Language = AMB.Language or {}
AMB.Language.table = AMB.Language.table or {}

-- ru: Russian
-- en: English

if CLIENT then CreateClientConVar( 'amb_lang', AMB.Config.language, true ) end

function AMB.Language.Add( sPattern, tLanguages )

    if not istable( tLanguages ) then AMB.ErrorLog( 'Language', 'The second argument is not a table' ) return end

    AMB.Language.table[ sPattern ] = tLanguages

    return AMB.Language.Get( sPattern )

end

function AMB.Language.AddBetweenRusAndEng( sPattern, sRussian, sEnglish, tOtherLanguages )

    sRussian = sRussian or ''
    sEnglish = sEnglish or sRussian

    AMB.Language.table[ sPattern ] = { ru = sRussian, en = sEnglish }

    if tOtherLanguages then AMB.Language.Add( sPattern, tOtherLanguages ) end

    return AMB.Language.Get( sPattern )

end

function AMB.Language.Get( sPattern )

    local lang = SERVER and AMB.Config.language or GetConVar( 'amb_lang' ):GetString()

    if not isstring( sPattern ) then sPattern = tostring( sPattern ) end
    if not AMB.Language.table[ sPattern ] then AMB.ErrorLog( 'Language', 'Pattern '..sPattern..' is not valid' ) return '' end
    if not AMB.Language.table[ sPattern ][ lang ] then AMB.ErrorLog( 'Language', 'In pattern '..sPattern..' is not valid language '..lang ) return '' end

    return AMB.Language.table[ sPattern ][ lang ]

end

function AMB.Language.GetTable( sPattern )

    return AMB.Language.table

end