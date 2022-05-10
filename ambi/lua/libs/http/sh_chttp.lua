Ambi.HTTP = Ambi.HTTP or {}
Ambi.HTTP.CHTTP = Ambi.HTTP.CHTTP or {}

local Gen = Ambi.General
local file = file
local IsWindows, ipairs, require = system.IsWindows, ipairs, require

-- -------------------------------------------------------------------------------------
local CHTTPS_FILES = {
    'gmsv_chttp_win64.dll',
    'gmsv_chttp_win64-dbg.dll',
    'gmsv_chttp_win32.dll',
    'gmsv_chttp_win32-dbg.dll',
    'gmsv_chttp_linux64.dll',
    'gmsv_chttp_linux64-dbg.dll',
    'gmsv_chttp_linux64-static.dll',
    'gmsv_chttp_linux64-dbg-static.dll',
    'gmsv_chttp_linux.dll',
    'gmsv_chttp_linux-dbg.dll',
    'gmsv_chttp_linux-static.dll',
    'gmsv_chttp_linux-dbg-static.dll'
}
local MAIN_DIR = 'LUA'
local EMPTY_STRING, EMPTRY_TABLE, EMPTY_FUNC, CONST_TYPE = '', {}, function() end, 'text/plain; charset=utf-8'

-- -------------------------------------------------------------------------------------
for index, name in ipairs( CHTTPS_FILES ) do
    -- Блок, связанный с чеком версий для Линукса и Винды, чекает по номеру в таблице, первые 4 для винды, остальные линукс. Пропускает 
    if IsWindows() then
        if ( index == 5 ) 
            or ( index == 6 ) 
            or ( index == 7 ) 
            or ( index == 8 ) 
            or ( index == 9 ) 
            or ( index == 10 ) 
            or ( index == 11 ) 
            or ( index == 11 ) 
            or ( index == 12 ) 
            or ( index == 13 ) 
            then continue 
        end
    else
        if ( index == 1 ) 
            or ( index == 2 ) 
            or ( index == 3 ) 
            or ( index == 4 ) 
            then continue 
        end
    end

    if file.Exists( 'bin/'..name, MAIN_DIR ) then 
        require( 'chttp' )
        Gen.Log( 'Connected outside library CHTTP ['..name..']' )
        Gen.Log( 'https://github.com/timschumi/gmod-chttp' )

        break  
    end
end

-- -------------------------------------------------------------------------------------
local CHTTP = CHTTP

function Ambi.HTTP.CHTTP.MakeRequest( tRequest )
    if not CHTTP then Gen.Error( 'HTTP.CHTTP', 'Library CHTTP is not connected' ) return end

    return CHTTP( tRequest )
end

function Ambi.HTTP.CHTTP.IsConnected()
    return CHTTP
end

function Ambi.HTTP.CHTTP.Post( sURL, OnSuccess, OnFailed, sBody, sType, tHeaders )
    if not CHTTP then Gen.Error( 'HTTP.CHTTP', 'Library CHTTP is not connected' ) return end
    if not sURL then Gen.Error( 'HTTP.CHTTP', 'Get request is not impossible, sURL == nil' ) return end
    
    return CHTTP( {
        url = sURL,
        method = 'POST',
        headers = tHeaders or EMPTRY_TABLE,
        body = sBody or EMPTY_STRING,
        type = sType or CONST_TYPE,
        success = OnSuccess or EMPTY_FUNC,
        failed = OnFailed or EMPTY_FUNC,
    } )
end

function Ambi.HTTP.CHTTP.Get( sURL, OnSuccess, OnFailed, tHeaders )
    if not CHTTP then Gen.Error( 'HTTP.CHTTP', 'Library CHTTP is not connected' ) return end
    if not sURL then Gen.Error( 'HTTP.CHTTP', 'Get request is not impossible, sURL == nil' ) return end
    
    return CHTTP( {
        url = sURL,
        success = OnSuccess or EMPTY_FUNC,
        failed = OnFailed or EMPTY_FUNC,
        method = 'GET',
        headers = tHeaders,
    } )
end