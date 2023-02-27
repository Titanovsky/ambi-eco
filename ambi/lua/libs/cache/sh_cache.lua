Ambi.Cache = Ambi.Cache or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
local Gen = Ambi.General
local Fetch, isstring, isnumber, print, file = http.Fetch, isstring, isnumber, print, file
local crc = util.CRC
local MIN_SIZE_FILE = 2
local MAX_SIZE_ATTEMPTS = 2^12

file.CreateDir( 'ambi/cache' )

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Cache.CacheURL( sPath, sURL, nAttempts, bNotRewrite ) -- Old
    if nAttempts and ( nAttempts == 0 ) then return end

    if not sPath or not isstring( sPath ) then return end
    if not sURL or not isstring( sURL ) then return end
    if not nAttempts or not isnumber( nAttempts ) or ( nAttempts < 0 ) or ( nAttempts >= MAX_SIZE_ATTEMPTS ) then Gen.Error( 'Cache', 'CacheURL | nAttempts is not valid or very long/small' ) return end
    nAttempts = nAttempts or 1

    Fetch( sURL, function( sBody, nSize ) 
        if bNotRewrite and file.Exists( sPath, 'DATA' ) then 
            local hash_body, hash_file = util.CRC( sBody ), util.CRC( file.Read( sPath, 'DATA' ) )
            if ( hash_body == hash_file ) then return end
        end

        file.Write( 'ambi/cache/'..sPath, sBody )
    end )

    timer.Simple( 0.55, function()
        if ( ( file.Size( sPath, 'DATA' ) or 0 ) > MIN_SIZE_FILE ) then return end

        Ambi.Cache.CacheURL( sPath, sURL, nAttempts - 1 )
    end )
end

function Ambi.Cache.GetCacheFile( sPath ) -- Old
    return '../data/ambi/cache/'..sPath
end

-- Выше два устаревших метода (до 28.04.2022), которые не будут обновляться!
-- ------------------------------------------------------------------------------------------------------------------------------
function Ambi.Cache.Add( sPath, sURL )
    if not sPath or not isstring( sPath ) then return end
    if not sURL or not isstring( sURL ) then return end

    local path = 'ambi/cache/'..sPath

    Fetch( sURL, function( sBody, nSize ) 
        file.Write( path, sBody )

        local file = file.Read( path )

        hook.Call( '[Ambi.Cache.Added]', nil, file, sPath, sURL )

        timer.Simple( 0.25, function()
            local hash1 = crc( file or '' )
            local hash2 = crc( sBody )
            if ( hash1 == hash2 ) then return end
    
            Ambi.Cache.Add( sPath, sURL )
        end )
    end )
end

function Ambi.Cache.Get( sPath )
    return '../data/ambi/cache/'..sPath
end

function Ambi.Cache.Material( sPath )
    return Material( '../data/ambi/cache/'..sPath )
end