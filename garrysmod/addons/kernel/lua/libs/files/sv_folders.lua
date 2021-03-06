AMB.Files.Folders = AMB.Files.Folders or {}

file = file

function AMB.Files.Folders.Create( sName, bOutFolderAmbition )

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName
    
    file.CreateDir( path )

    return true

end

function AMB.Files.Folders.Find( sName, sPattern, sSorting, bOutFolderAmbition )

    sPattern = sPattern or DATA

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    local _, folders = file.Find( path, sPattern, sSorting )

    return folders

end

function AMB.Files.Folders.CreateAmbition()

    if not file.IsDir( 'ambition/', 'DATA' ) then AMB.Files.Folders.Create( 'ambition', true ) end

end

function AMB.Files.Folders.CreateServer()

    if not file.IsDir( 'ambition/'..AMB.Config.server_dir, 'DATA' ) then AMB.Files.Folders.Create( 'ambition/'..AMB.Config.server_dir, true ) end

end

AMB.Files.Folders.CreateAmbition()
AMB.Files.Folders.CreateServer()