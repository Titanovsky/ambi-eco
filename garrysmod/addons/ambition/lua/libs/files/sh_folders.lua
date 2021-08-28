AMB.Files.Folders = AMB.Files.Folders or {}

local file = file

function AMB.Files.Folders.Create( sName, bOutFolderAmbition )
    local path = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName

    file.CreateDir( path )
end

function AMB.Files.Folders.Find( sName, sPattern, sSorting, bOutFolderAmbition )
    sPattern = sPattern or 'DATA'

    local path = bOutFolderAmbition and sName or AMB.Files.SERVER_DIR..sName
    local _, folders = file.Find( path, sPattern, sSorting )

    return folders
end

function AMB.Files.Folders.CreateAmbition()
    if not file.IsDir( AMB.Files.SERVER_DIR, 'DATA' ) then AMB.Files.Folders.Create( AMB.Files.SERVER_DIR, true ) end
end

function AMB.Files.Folders.CreateServer()
    if not file.IsDir( AMB.Files.SERVER_DIR..AMB.Config.directory, 'DATA' ) then AMB.Files.Folders.Create( AMB.Files.SERVER_DIR..AMB.Config.directory, true ) end
end