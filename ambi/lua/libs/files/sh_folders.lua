Ambi.Files.Folders = Ambi.Files.Folders or {}

local file = file

function Ambi.Files.Folders.Create( sName, bInConfigFolder )
    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName

    file.CreateDir( path )
end

function Ambi.Files.Folders.Find( sName, sPattern, sSorting, bInConfigFolder )
    sPattern = sPattern or 'DATA'

    local path = bInConfigFolder and Ambi.Files.SERVER_DIR..sName or sName
    local _, folders = file.Find( path, sPattern, sSorting )

    return folders
end

function Ambi.Files.Folders.CreateConfigFolder()
    if not file.IsDir( Ambi.Files.SERVER_DIR, 'DATA' ) then Ambi.Files.Folders.Create( Ambi.Files.SERVER_DIR, true ) end
end

function Ambi.Files.Folders.CreateServer()
    if not file.IsDir( Ambi.Files.SERVER_DIR..Ambi.Config.directory, 'DATA' ) then Ambi.Files.Folders.Create( Ambi.Files.SERVER_DIR..Ambi.Config.directory, true ) end
end