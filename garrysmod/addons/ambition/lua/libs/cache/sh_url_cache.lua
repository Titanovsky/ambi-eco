AMB.Cache = AMB.Cache or {}

local A = AMB.Ambition
local Fetch, isstring, isnumber, print, file = http.Fetch, isstring, isnumber, print, file

function AMB.Cache.CacheURL( sPath, sURL, nAttempts )
    if nAttempts and ( nAttempts == 0 ) then
        if ( file.Size( sPath, 'DATA' ) > 2 ) then return end

        return
    end

    if not sPath or not isstring( sPath ) then return end
    if not sURL or not isstring( sURL ) then return end
    if not nAttempts or not isnumber( nAttempts ) or ( nAttempts < 0 ) or ( nAttempts >= 256 ) then A.Error( 'Cache', 'nAttempts is not valid or very long/small' ) return end
    nAttempts = nAttempts or 1

    Fetch( sURL, function( sBody, nSize ) 
        file.Write( sPath, sBody )
    end )

    timer.Simple( 0.55, function()
        if ( ( file.Size( sPath, 'DATA' ) or 0 ) > 2 ) then return end

        AMB.Cache.CacheURL( sType, sPath, sURL, nAttempts - 1 )
    end )
end