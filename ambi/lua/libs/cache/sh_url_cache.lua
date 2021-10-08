Ambi.Cache = Ambi.Cache or {}

local Gen = Ambi.General
local Fetch, isstring, isnumber, print, file = http.Fetch, isstring, isnumber, print, file
local MIN_SIZE_FILE = 2

function Ambi.Cache.CacheURL( sPath, sURL, nAttempts, bNotRewrite )
    if nAttempts and ( nAttempts == 0 ) then return end

    if not sPath or not isstring( sPath ) then return end
    if not sURL or not isstring( sURL ) then return end
    if not nAttempts or not isnumber( nAttempts ) or ( nAttempts < 0 ) or ( nAttempts >= 256 ) then Gen.Error( 'Cache', 'CacheURL() | nAttempts is not valid or very long/small' ) return end
    nAttempts = nAttempts or 1

    Fetch( sURL, function( sBody, nSize ) 
        if bNotRewrite and file.Exists( sPath, 'DATA' ) then 
            local hash_body, hash_file = util.CRC( sBody ), util.CRC( file.Read( sPath, 'DATA' ) )
            if ( hash_body == hash_file ) then return end
        end

        file.Write( sPath, sBody )
    end )

    timer.Simple( 0.55, function()
        if ( ( file.Size( sPath, 'DATA' ) or 0 ) > MIN_SIZE_FILE ) then return end

        Ambi.Cache.CacheURL( sType, sPath, sURL, nAttempts - 1 )
    end )
end