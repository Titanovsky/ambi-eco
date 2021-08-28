AMB = AMB or {}
AMB.Modules, AMB.Libs, AMB.Config = AMB.Modules or {}, AMB.Libs or {}, AMB.Config or {}

-- Redefinitation ----------------------------------------------------------------------------------
local FileFind, FileInclude, FileClientAdd = file.Find, include, AddCSLuaFile
local StringExplode, StringSetChar, StringUpper, StringStart = string.Explode, string.SetChar, string.upper, string.StartWith
local Print, TablePrint, Pairs, IntPairs, WorkshopAdd = print, PrintTable, pairs, ipairs, resource.AddWorkshop
----------------------------------------------------------------------------------------------------
local current_module, current_lib = nil

local function FileSharedInitialize( sFile )
    if ( sFile == nil ) then return end

    FileInclude( sFile )
    FileClientAdd( sFile )
end

local function FileServerInitialize( sFile )
    if ( sFile == nil ) then return end

    if SERVER then FileInclude( sFile ) end
end

local function FileClientInitialize( sFile )
    if ( sFile == nil ) then return end

    if SERVER then FileClientAdd( sFile ) else FileInclude( sFile ) end
end

local function FileWorkshopInitialize( sFile )
    if CLIENT then return end
    if ( sFile == nil ) then return end

    local name = StringExplode( '/', sFile )
    name = name[ #name ]
    name = StringExplode( '.', name )[ 1 ]

    local pieces = StringExplode( '_', name )
    local id = pieces[ 2 ]

    local title = ''
    for i, word in IntPairs( pieces ) do
        if ( i == 1 ) or ( i == 2 ) then continue end -- 1: "wid" - flag, 2: "123123" - number

        local endmark = ( i == 3 ) and '' or ' '
        title = title..endmark..StringSetChar( word, 1, StringUpper( word[ 1 ] ) )
    end

    WorkshopAdd( id )
    Print( '[Workshop] Initialized ['..id..'] ['..title..']' )
end

local flags_init = {
    [ 'sh' ] = FileSharedInitialize,
    [ 'sv' ] = FileServerInitialize,
    [ 'cl' ] = FileClientInitialize,

    [ 'cfg' ] = FileSharedInitialize,
    [ 'ent' ] = FileSharedInitialize,
    [ 'wep' ] = FileSharedInitialize,
    [ 'npc' ] = FileSharedInitialize,

    [ 'wid' ] = FileWorkshopInitialize
}

local function FilesLoad( sPath )
    if ( sPath == nil ) then return end

    local pieces = StringExplode( '/', sPath )
    local name = pieces[ #pieces ]
    local flag = StringExplode( '_', name )[ 1 ]
    local Initialize = flags_init[ flag ]
    if ( Initialize == nil ) then return end

    Initialize( sPath )
end

local function FilesAdd( sDirectory, bModule )
    if ( sDirectory == nil ) then return end

    local files, directories = FileFind( sDirectory..'/*', 'LUA' )
    for _, file in IntPairs( files ) do 
        local path = sDirectory..'/'..file

        FilesLoad( path ) 

        if bModule then 
            local len = #AMB.Modules[ current_module ]
            AMB.Modules[ current_module ][ len + 1 ] = path
        else 
            local len = #AMB.Libs[ current_lib ]
            AMB.Libs[ current_lib ][ len + 1 ] = path
        end   
    end
    for _, dir in IntPairs( directories ) do FilesAdd( sDirectory..'/'..dir, bModule ) end
end

local NAMES_LIBRARIES = {
    [ 'Ambition' ] = true,
    [ 'Cache' ] = true,
    [ 'Download' ] = true,
    [ 'Entity' ] = true,
    [ 'Files' ] = true,
    [ 'HTTP' ] = true,
    [ 'NW' ] = true,
    [ 'Player' ] = true,
    [ 'RegEntity' ] = true,
    [ 'SQL' ] = true,
    [ 'Timer' ] = true,
    [ 'UI' ] = true,
}

function AMB.ConnectModule( sTableTitle, sNameDirectoryModule, sDescription )
    if ( sTableTitle == nil ) or ( sNameDirectoryModule == nil ) then print( '[Error] AMB.ConnectModule | not selected headers!' ) return end
    if NAMES_LIBRARIES[ sTableTitle ] then print( '[Error] AMB.ConnectModule | name '..sTableTitle..' is occupaited by library!' ) return end
    if AMB.Modules[ sTableTitle ] then return end

    AMB.Modules[ sTableTitle ] = {}
    AMB[ sTableTitle ] = {}
    AMB[ sTableTitle ][ 'Config' ] = {}

    current_module = sTableTitle
    FilesAdd( 'modules/'..sNameDirectoryModule, true )

    if CLIENT then return end
    
    Print( '[Modules] Connected '..sTableTitle..' - '..sDescription )
end

local function LoaderConnectLibs()
    local _, libs = FileFind( 'libs/*', 'LUA' )

    for _, lib in IntPairs( libs ) do 
        if AMB.Libs[ lib ] then continue end

        AMB.Libs[ lib ] = {}
        current_lib = lib
        FilesAdd( 'libs/'..lib, false )
    end

    if CLIENT then return end

    Print( '==================================================' ) 
    Print( '[Libraries] Connected:' ) 
    for lib, _ in Pairs( AMB.Libs ) do
        local name = StringSetChar( lib, 1, StringUpper( lib[ 1 ] ) )
        Print( '\t• '..name )
    end
    Print( '==================================================' ) 
end

local function LoaderConnect( sPath )
    FileInclude( sPath )
    FileClientAdd( sPath )
end

local function LoaderConnectWorkshopIDFromAddons()
    local _, dirs = FileFind( 'addons/*', 'GAME' )

    for _, dir in IntPairs( dirs ) do
        local files, _ = FileFind( 'addons/'..dir..'/*', 'GAME' )
        for _, file in IntPairs( files ) do
            if ( StringStart( file, 'wid' ) == false ) then continue end

            FileWorkshopInitialize( dir..'/'..file ) 
        end
    end
end

----------------------------------------------------------------------------------------------------
LoaderConnectLibs()                
LoaderConnectWorkshopIDFromAddons() 
LoaderConnect( 'ambition_config.lua' )               

local CFG = AMB.Config
local ConsoleRun, FileDirCreate, FileExists = RunConsoleCommand, file.CreateDir, file.Exists

if ( FileExists( '[ambition]', 'DATA' ) == false ) then FileDirCreate( '[ambition]' ) end -- checking on existence of a folder 
if ( FileExists( '[ambition]/'..CFG.directory, 'DATA' ) == false ) then FileDirCreate( '[ambition]/'..CFG.directory ) end
----------------------------------------------------------------------------------------------------