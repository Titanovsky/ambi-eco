AMB.Files = AMB.Files or {}
AMB.Files.global_dir = 'ambition/'

file = file
util = util

local DATA = 'DATA'

function AMB.Files.CreateDir( sName, bOutFolderAmbition )

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName
    
    file.CreateDir( path )
    AMB.ConsoleLog( 'Created the Folder: '..path )

    return true

end

function AMB.Files.CreateFolder( sName, bOutFolderAmbition )

    AMB.Files.CreateDir( sName, bOutFolderAmbition )

end

function AMB.Files.CreateFile( sName, sContent, bOutFolderAmbition )

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName
    local is_file = file.Exists( path, DATA )

    print( path )

    file.Write( path, sContent )

    if is_file then 

        AMB.ConsoleLog( 'Rewrite the File: '..path )

    else

        AMB.ConsoleLog( 'Created the File: '..path )

    end

    return true

end

function AMB.Files.CreateNewFile( sName, sContent, bOutFolderAmbition )

    local path = bOutFolderAmbition and AMB.Files.global_dir..sName or sName
    local is_file = AMB.Files.Valid( path )

    if is_file then 

        AMB.ErrorLog( 'File | Cannot create the new file '..path..', cuz he is valid' )

        return false

    else

        file.Write( path, sContent )
        AMB.ConsoleLog( 'Created the new File: '..path )

        return true

    end

end

function AMB.Files.Remove( sName )

    file.Delete( sName )

    AMB.ConsoleLog( 'Deleted File/Folder in: '..sName )

end

function AMB.Files.Valid( sName, sPattern )

    sPattern = sPattern or DATA

    if ( file.Size( sName, sPattern ) >= 2 ) then return true end

    return false

end

function AMB.Files.FindFiles( sName, sPattern, sSorting, bOutFolderAmbition )

    sPattern = sPattern or DATA

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    local files, _ = file.Find( path, sPattern, sSorting )

    return files

end

function AMB.Files.FindFolders( sName, sPattern, sSorting, bOutFolderAmbition )

    sPattern = sPattern or DATA

    local path = bOutFolderAmbition and sName or AMB.Files.global_dir..sName

    local _, folders = file.Find( path, sPattern, sSorting )

    return folders

end

function AMB.Files.CreateGlobalFolder()

    if not file.IsDir( 'ambition/', DATA ) then AMB.Files.CreateDir( 'ambition', true ) end

end
AMB.Files.CreateGlobalFolder()

function AMB.Files.CreateServerFolder()

    if not file.IsDir( 'ambition/'..AMB.Config.server_dir, DATA ) then AMB.Files.CreateDir( 'ambition/'..AMB.Config.server_dir, true ) end

end
AMB.Files.CreateServerFolder()

function AMB.Files.InJSON( tData, bPrint )

    bPrint = bPrint or false

    local data_str = util.TableToJSON( tData, bPrint )

    return data_str

end

function AMB.Files.OutJSON( sJSON )

    local data_tab = util.JSONToTable( sJSON )

    return data_tab

end
