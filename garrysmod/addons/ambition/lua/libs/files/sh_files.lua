AMB.Files = AMB.Files or {}
AMB.Files.WHITELIST_TYPES = {
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
AMB.Files.SERVER_DIR = '[ambition]/'

local file, timer, print = file, timer, print

function AMB.Files.Create( sName, sContent, bOutFolderAmbition )
    local path = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    file.Write( path, sContent or '' )

    return true
end

function AMB.Files.CreateSafe( sName, sContent, bOutFolderAmbition )
    local path = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName
    local file_valid = AMB.Files.Valid( path, 'DATA', true )

    if file_valid then return false end

    file.Write( path, sContent or '' )

    return true
end

function AMB.Files.Remove( sName, bOutFolderAmbition )
    sName = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    file.Delete( sName )
end

function AMB.Files.Valid( sName, sPattern, bOutFolderAmbition )
    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    if ( file.Size( sName, sPattern ) >= 1 ) then return true end

    return false
end

function AMB.Files.Find( sName, sPattern, sSorting, bOutFolderAmbition )
    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    local files, _ = file.Find( sName, sPattern, sSorting )

    return files
end

function AMB.Files.Read( sName, sPattern, bOutFolderAmbition )
    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName
    
    return file.Read( sName, sPattern )
end

function AMB.Files.Append( sName, sContent, bOutFolderAmbition )
    local path = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    file.Append( path, sContent or '' )

    return true
end

function AMB.Files.GetSize( sName, sPattern, bOutFolderAmbition )
    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    return file.Size( sName, sPattern )
end

-- todo
--[[ 
function AMB.Files:Create( sName, sType, sPath, sContent, bLog )
    sName = sName or 'test'
    sType = sType or 'txt'
    sPath = sPath or 'ambition'
    sContent = sContent or ''

    if ( Files.whitelist_types[ sType ] == false ) then AMB.Ambition.Error( 'Files', 'Must not create file with sType .'..sType ) return end

    local path = sPath..'/'..sName..'.'..sType

    file.Write( path, sContent or '' )

    if ( bLog == nil ) or ( bLog == false ) then return end

    local size = file.Size( path, 'DATA' )
    if ( size > 0 ) then print( '[Files] Created '..path ) return end
end
]]