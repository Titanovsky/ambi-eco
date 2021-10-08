Ambi.Files = Ambi.Files or {}
Ambi.Files.WHITELIST_TYPES = {
    [ 'txt' ] = true,
    [ 'dat' ] = true,
    [ 'json' ] = true,
    [ 'xml' ] = true,
    [ 'csv' ] = true,
    [ 'jpg' ] = true,
    [ 'jpeg' ] = true,
    [ 'png' ] = true,
    [ 'vtf' ] = true,
    [ 'vmt' ] = true,
    [ 'mp3' ] = true,
    [ 'wav' ] = true,
    [ 'ogg' ] = true
}
Ambi.Files.SERVER_DIR = '[ambi]/'

local file, timer, print = file, timer, print

function Ambi.Files.Create( sName, sContent, bInConfigFolder )
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    file.Write( path, sContent or '' )

    return true
end

function Ambi.Files.CreateSafe( sName, sContent, bInConfigFolder )
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName
    local file_valid = Ambi.Files.Valid( path, 'DATA', true )

    if file_valid then return false end

    file.Write( path, sContent or '' )

    return true
end

function Ambi.Files.Remove( sName, bInConfigFolder )
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    file.Delete( path )
end

function Ambi.Files.Valid( sName, sPattern, bInConfigFolder )
    sPattern = sPattern or 'DATA'
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    if ( file.Size( path, sPattern ) >= 1 ) then return true end

    return false
end

function Ambi.Files.Find( sName, sPattern, sSorting, bInConfigFolder )
    sPattern = sPattern or 'DATA'
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    local files, _ = file.Find( path, sPattern, sSorting )

    return files
end

function Ambi.Files.Read( sName, sPattern, bInConfigFolder )
    sPattern = sPattern or 'DATA'
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName
    
    return file.Read( path, sPattern )
end

function Ambi.Files.Append( sName, sContent, bInConfigFolder )
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    file.Append( path, sContent or '' )

    return true
end

function Ambi.Files.GetSize( sName, sPattern, bInConfigFolder )
    sPattern = sPattern or 'DATA'
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    return file.Size( path, sPattern )
end