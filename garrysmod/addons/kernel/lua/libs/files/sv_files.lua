AMB.Files = AMB.Files or {}
AMB.Files.global_dir = 'ambition/'..AMB.Config.server_dir..'/'

file = file

function AMB.Files.Create( sName, sContent, bOutFolderAmbition )

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    file.Write( path, sContent )

    return true

end

function AMB.Files.CreateSafe( sName, sContent, bOutFolderAmbition )

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName
    local file_valid = AMB.Files.Valid( path, 'DATA', true )

    if file_valid then return false end

    file.Write( path, sContent )

    return true

end

function AMB.Files.Remove( sName, bOutFolderAmbition )

    sName = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    file.Delete( sName )

end

function AMB.Files.Valid( sName, sPattern, bOutFolderAmbition )

    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    if ( file.Size( sName, sPattern ) >= 1 ) then return true end

    return false

end

function AMB.Files.Find( sName, sPattern, sSorting, bOutFolderAmbition )

    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    local files, _ = file.Find( sName, sPattern, sSorting )

    return files

end

function AMB.Files.Read( sName, sPattern, bOutFolderAmbition )

    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.global_dir..sName
    
    return file.Read( sName, sPattern )

end

function AMB.Files.GetSize( sName, sPattern, bOutFolderAmbition )

    sPattern = sPattern or 'DATA'
    sName = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    return file.Size( sName, sPattern )

end