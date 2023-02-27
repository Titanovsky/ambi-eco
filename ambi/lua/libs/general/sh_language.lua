Ambi.General.Language = Ambi.General.Language or {}

-- -------------------------------------------------------------------------------------
local istable, GetConVarString, tostring, isstring = istable, GetConVarString, tostring, isstring
local phrases = {} --! DON'T RESAVE THIS FILE, WHEN YOUR SERVER WORKING! I made this decision for faster check in every frame (see Ambi.UI.Draw.Text)

-- -------------------------------------------------------------------------------------
function Ambi.General.Language.Add( sPattern, tLanguages )
    if not tLanguages or istable( tLanguages ) then return end
    if not sPattern or isstring( sPattern ) then return end

    phrases[ sPattern ] = tLanguages

    return Ambi.General.Language.Get( sPattern )
end

function Ambi.General.Language.Get( sPattern )
    if not phrases[ sPattern ] then return sPattern end

    local lang = GetConVarString( 'gmod_language' )
    if not phrases[ sPattern ][ lang ] then return ( phrases[ sPattern ][ 'en' ] or sPattern ) end -- Если языка нет, то Английский, либо никакой

    return phrases[ sPattern ][ lang ]
end

function Ambi.General.Language.SimpleAdd( sPattern, sRussian, sEnglish )
    sRussian = sRussian or ''
    sEnglish = sEnglish or sRussian

    phrases[ sPattern ] = { ru = sRussian, en = sEnglish }

    return Ambi.General.Language.Get( sPattern )
end

function Ambi.General.Language.GetPhrases()
    return phrases
end