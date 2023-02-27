Ambi.Cache = Ambi.Cache or {}
Ambi.Cache.models = Ambi.Cache.models or {}
Ambi.Cache.sounds = Ambi.Cache.sounds or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
local C = nil
local MAX_CACHED_MODELS = 3998 -- 4096
local MAX_CACHED_SOUNDS = 15998 -- 16384

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
local util_PrecacheModel = util.PrecacheModel
function util.PrecacheModel( sModel )
    if not C then C = Ambi.General.Global.Colors end
    if Ambi.Cache.models[ sModel ] then return end

    local i = 0
    for _, __ in pairs( Ambi.Cache.models ) do
        i = i + 1
    end
    
    if ( i >= MAX_CACHED_MODELS ) then MsgC( C.AMBI_GREEN, '[Ambi.Cache] ', C.AMBI_WHITE, 'Cannot to cache more models than '..MAX_CACHED_MODELS..'\n' ) return end

    local amount = i + 1
    MsgC( C.AMBI_GREEN, '[Ambi.Cache] ', C.AMBI_WHITE, 'Precached model: ', C.AMBI_GRAY, sModel..' ['..amount..']\n' )

    Ambi.Cache.models[ sModel ] = sModel

    return util_PrecacheModel( sModel )
end

local util_PrecacheSound = util.PrecacheSound
function util.PrecacheSound( sSound )
    if not C then C = Ambi.General.Global.Colors end
    if Ambi.Cache.sounds[ sSound ] then return end

    local i = 0
    for _, __ in pairs( Ambi.Cache.sounds ) do
        i = i + 1
    end
    
    if ( i >= MAX_CACHED_SOUNDS ) then MsgC( C.AMBI_GREEN, '[Ambi.Cache] ', C.AMBI_WHITE, 'Cannot to cache more sounds than '..MAX_CACHED_SOUNDS..'\n' ) return end

    local amount = i + 1
    MsgC( C.AMBI_GREEN, '[Ambi.Cache] ', C.AMBI_WHITE, 'Precached sound: ', C.AMBI_BLUE, sSound..' ['..amount..']\n' )

    Ambi.Cache.sounds[ sSound ] = sSound

    return util_PrecacheSound( sSound )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Cache.AddModel( sModel )
    if not sModel then return end

    util.PrecacheModel( sModel )
end

function Ambi.Cache.AddSound( sSound )
    if not sSound then return end
    
    util.PrecacheSound( sSound )
end