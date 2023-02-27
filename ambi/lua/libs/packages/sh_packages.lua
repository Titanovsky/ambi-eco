Ambi.Packages = Ambi.Packages or {}
Ambi.Packages.PATTERNS = Ambi.Packages.PATTERNS or {}
Ambi.Packages.SPECIFIC_PATTERNS = Ambi.Packages.SPECIFIC_PATTERNS or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local has_pull = false
local unpack = unpack
local Split, Lower = string.Split, string.lower

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function PullPatterns()
    Ambi.Packages.PATTERNS = { -- Все нижнем регистром, так как чекаться будет после изменения ключа в нижний регистр
        [ 'general' ] = Ambi.General,
        [ 'gen' ] = Ambi.General,
        [ 'global' ] = Ambi.General.Global,
        [ 'hash' ] = Ambi.General.Hash,
        [ 'bench' ] = Ambi.General.Bench,
        [ 'math' ] = Ambi.General.Math,
        [ 'c' ] = Ambi.General.Global.Colors,
        [ 'colors' ] = Ambi.General.Global.Colors,
        [ 'snd' ] = Ambi.General.Global.Sounds,
        [ 'sounds' ] = Ambi.General.Global.Sounds,
        [ 'words' ] = Ambi.General.Global.Words,
        [ 'keys' ] = Ambi.General.Global.Keys,
        [ 'lang' ] = Ambi.General.Language,
        [ 'language' ] = Ambi.General.Language,
        [ 'util' ] = Ambi.General.Utility,
        [ 'coding' ] = Ambi.General.Utility.Coding,
        [ 'random' ] = Ambi.General.Utility.Random,
        [ 'ui' ] = Ambi.UI,
        [ 'gui' ] = Ambi.UI.GUI,
        [ 'draw' ] = Ambi.UI.Draw,
        [ 'chat' ] = Ambi.UI.Chat,
        [ 'sound' ] = Ambi.UI.Sound,
        [ 'notify' ] = Ambi.UI.Notify,
        [ 'sql' ] = Ambi.SQL,
        [ 'regentity' ] = Ambi.RegEntity,
        [ 'nw' ] = Ambi.NW,
        [ 'timer' ] = Ambi.Timer,
        [ 'cache' ] = Ambi.Cache,
        [ 'download' ] = Ambi.Download,
        [ 'http' ] = Ambi.HTTP,
        [ 'files' ] = Ambi.Files,
        [ 'savedata' ] = Ambi.SaveData,
        [ 'json' ] = Ambi.JSON,
    }

    Ambi.Packages.SPECIFIC_PATTERNS = {
        [ '@a' ] = { Ambi.General, Ambi.General.Global.Colors, Ambi.General.Global.Sounds },
        [ '@all' ] = { Ambi.General, Ambi.General.Global.Colors, Ambi.General.Global.Sounds },

        [ '@d' ] = { Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw, Ambi.UI },
        [ '@design' ] = { Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Draw, Ambi.UI },

        [ '@u' ] = { Ambi.General.Utility, Ambi.General.Utility.Coding, Ambi.General.Utility.Random },
        [ '@utility' ] = { Ambi.General.Utility, Ambi.General.Utility.Coding, Ambi.General.Utility.Random },
    }
end

function Ambi.Packages.Out( anyKeys )
    if not has_pull then -- Сделано, так как не все модули/библиотеки могут подключиться раньше этой библиотеки
        PullPatterns() 
        has_pull = true 
    end

    local package = {}

    local keys = string.Split( anyKeys, ',' )
    for _, key in ipairs( keys ) do
        key = string.Trim( key )

        local specific = Ambi.Packages.SPECIFIC_PATTERNS[ key ]
        if specific then 
            for _, also_key in ipairs( specific ) do package[ #package + 1 ] = also_key end
        end

        local pattern = Ambi.Packages.PATTERNS[ Lower( key ) ]
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