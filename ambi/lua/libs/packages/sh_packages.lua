Ambi.Packages = Ambi.Packages or {}

local unpack = unpack
local Split, Lower = string.Split, string.lower
local PATTERNS, SPECIFIC_PATTERNS

local function PullPatterns()
    PATTERNS = { -- Все нижнем регистром, так как чекаться будет после изменения ключа в нижний регистр
        [ 'gen' ] = Ambi.General,
        [ 'global' ] = Ambi.General.Global,
        [ 'c' ] = Ambi.General.Global.Colors,
        [ 'colors' ] = Ambi.General.Global.Colors,
        [ 'snd' ] = Ambi.General.Global.Sounds,
        [ 'sounds' ] = Ambi.General.Global.Sounds,
        [ 'sound' ] = Ambi.General.Global.Sounds,
        [ 'ui' ] = Ambi.UI,
        [ 'gui' ] = Ambi.UI.GUI,
        [ 'draw' ] = Ambi.UI.Draw,
        [ 'sql' ] = Ambi.SQL,
        [ 'regentity' ] = Ambi.RegEntity,
        [ 'nw' ] = Ambi.NW,
        [ 'timer' ] = Ambi.Timer,
        [ 'cache' ] = Ambi.Cache,
        [ 'download' ] = Ambi.Download,
        [ 'http' ] = Ambi.HTTP,
        [ 'files' ] = Ambi.Files,
    }

    SPECIFIC_PATTERNS = {
        [ '@a' ] = { Ambi.General, Ambi.General.Global.Colors, Ambi.General.Global.Sounds },
        [ '@all' ] = { Ambi.General, Ambi.General.Global.Colors, Ambi.General.Global.Sounds },

        [ '@d' ] = { Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw },
        [ '@design' ] = { Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw },
    }
end

function Ambi.Packages.Out( anyKeys )
    if not PATTERNS then PullPatterns() end -- Сделано, так как не все модули/библиотеки могут подключиться раньше этой библиотеки

    local package = {}

    local keys = string.Split( anyKeys, ',' )
    for _, key in ipairs( keys ) do
        key = string.Trim( key )

        local specific = SPECIFIC_PATTERNS[ key ]
        if specific then 
            for _, also_key in ipairs( specific ) do package[ #package + 1 ] = also_key end

            continue
        end

        local pattern = PATTERNS[ Lower( key ) ]
        if pattern then 
            key = pattern 
        else
            local tables = Split( key, '.' )
            local tab = Ambi

            for _, next_tab in ipairs( tables ) do
                tab = tab[ next_tab ]
            end

            key = tab
        end

        package[ #package + 1 ] = key
    end

    return unpack( package )
end