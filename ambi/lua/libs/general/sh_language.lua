Ambi.General.Language = Ambi.General.Language or {}

local istable, GetConVarString, tostring, isstring = istable, GetConVarString, tostring, isstring
local phrases = {}

function Ambi.General.Language.Add( sPattern, tLanguages )
    if not tLanguages or istable( tLanguages ) then return end
    if not sPattern or isstring( sPattern ) then return end

    phrases[ sPattern ] = tLanguages

    return Ambi.General.Language.Get( sPattern )
end

function Ambi.General.Language.Get( sPattern )
    local lang = SERVER and Ambi.Config.language or GetConVarString( 'gmod_language' )

    sPattern = tostring( sPattern )
    if not phrases[ sPattern ] then return '' end
    if not phrases[ sPattern ][ lang ] then return '' end

    return Ambi.General.Language.table[ sPattern ][ lang ]
end

function Ambi.General.Language.AddBetweenRussianAndEnglish( sPattern, sRussian, sEnglish )
    sRussian = sRussian or ''
    sEnglish = sEnglish or sRussian

    phrases[ sPattern ] = { ru = sRussian, en = sEnglish }

    return Ambi.General.Language.Get( sPattern )
end

function Ambi.General.Language.GetPhrases()
    return phrases
end