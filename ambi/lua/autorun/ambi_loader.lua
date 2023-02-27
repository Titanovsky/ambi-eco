Ambi = Ambi or {}
Ambi.version = '6.6'

print( '\n==================================' )
print( '|| \tAmbi Eco v'..Ambi.version..' \t||' )
print( '==================================\n' )

AMB = setmetatable( AMB or {}, { __index = Ambi } )-- для совместимости

Ambi.Modules, Ambi.Libs, Ambi.Config = Ambi.Modules or {}, Ambi.Libs or {}, Ambi.Config or {}

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
    Print( '[Workshop] Added ['..id..'] ['..title..']' )
end

local flags_init = {
    [ 'shared' ] = FileSharedInitialize,
    [ 'sh' ] = FileSharedInitialize,
    [ 'server' ] = FileServerInitialize,
    [ 'sv' ] = FileServerInitialize,
    [ 'client' ] = FileClientInitialize,
    [ 'cl' ] = FileClientInitialize,

    [ 'config' ] = FileSharedInitialize,
    [ 'cfg' ] = FileSharedInitialize,
    [ 'entity' ] = FileSharedInitialize,
    [ 'ent' ] = FileSharedInitialize,
    [ 'weapon' ] = FileSharedInitialize,
    [ 'gun' ] = FileSharedInitialize,
    [ 'wep' ] = FileSharedInitialize,
    [ 'tool' ] = FileSharedInitialize,
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
            local len = #Ambi.Modules[ current_module ]
            Ambi.Modules[ current_module ][ len + 1 ] = path
        else 
            local len = #Ambi.Libs[ current_lib ]
            Ambi.Libs[ current_lib ][ len + 1 ] = path
        end   
    end
    for _, dir in IntPairs( directories ) do FilesAdd( sDirectory..'/'..dir, bModule ) end
end

local NAMES_LIBRARIES = {
    [ 'General' ] = true,
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
    [ 'Packages' ] = true,
    [ 'JSON' ] = true,
    [ 'SaveData' ] = true,
}

function Ambi.CreateModule( sTable )
    Ambi[ sTable ] = Ambi[ sTable ] or {}
    Ambi[ sTable ][ 'Config' ] = Ambi[ sTable ][ 'Config' ] or {}

    return Ambi[ sTable ], Ambi[ sTable ][ 'Config' ]
end

function Ambi.ConnectModule( sNameDirectoryModule, sDescription )
    if ( sNameDirectoryModule == nil ) then print( '[Error] Ambi.ConnectModule | Not selected name of directory!' ) return end
    if Ambi.Modules[ sNameDirectoryModule ] then return end
    
    local is_exists = false
    local _, folders = file.Find( 'modules/*', "LUA" )
    for _, dir in ipairs( folders ) do
        if ( dir == sNameDirectoryModule ) then is_exists = true break end -- workaround: https://github.com/Facepunch/garrysmod-issues/issues/1038
    end
    if not is_exists then return end

    Ambi.Modules[ sNameDirectoryModule ] = {}

    current_module = sNameDirectoryModule
    FilesAdd( 'modules/'..sNameDirectoryModule, true )

    if CLIENT then return end
    
    sDescription = sDescription or ''

    Print( '[Modules] Connected '..sNameDirectoryModule..' • '..sDescription )
end

function Ambi.ConnectGamemode( sTableTitle, sNameDirectoryModule )
    if Ambi.gamemode then return print( '[Error] Ambi.ConnectGamemode | the gamemode connected!' ) end

    Ambi.gamemode = sTableTitle

    Ambi.ConnectModule( sTableTitle, sNameDirectoryModule, 'Gamemode' )
end

local function LoaderConnectLibs()
    Ambi.General = Ambi.General or {}
    Ambi.Ambition = setmetatable( Ambi.Ambition or {}, { __index = Ambi.General } ) -- for compatibility with legacy
    AMB.Ambition = setmetatable( AMB.Ambition or {}, { __index = Ambi.General } ) -- for compatibility with legacy

    local _, libs = FileFind( 'libs/*', 'LUA' )
    for _, lib in IntPairs( libs ) do 
        if Ambi.Libs[ lib ] then continue end

        Ambi.Libs[ lib ] = {}
        current_lib = lib
        FilesAdd( 'libs/'..lib, false )
    end

    if CLIENT then return end

    Print( '==================================================' ) 
    Print( '[Libraries] Connected:' ) 
    for lib, _ in Pairs( Ambi.Libs ) do
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
    if not dirs then return end

    for _, dir in IntPairs( dirs ) do
        local files, _ = FileFind( 'addons/'..dir..'/*', 'GAME' )
        if not files then continue end
        
        for _, file in IntPairs( files ) do
            if StringStart( file, 'wid' ) then FileWorkshopInitialize( dir..'/'..file ) end
        end
    end
end

local function LoaderAutoConnect()
    local _, modules = FileFind( 'modules/*', 'LUA' )
    if not modules then return end

    for _, module in IntPairs( modules ) do 
        local files, _ = FileFind( 'modules/'..module..'/*', 'LUA' )
        if not files then continue end

        for _, file in IntPairs( files ) do
            if StringStart( file, 'autoload' ) then FileSharedInitialize( 'modules/'..module..'/'..file ) end
        end
    end
end

----------------------------------------------------------------------------------------------------

----------------------- ORDER LOADING -------------------------
LoaderConnectLibs()                
LoaderConnectWorkshopIDFromAddons() 
LoaderAutoConnect()
LoaderConnect( 'ambi_config.lua' )
---------------------------------------------------------------

if ( Ambi.Config.dev == nil ) then Ambi.Config.dev = false end
if ( Ambi.Config.language == nil ) then Ambi.Config.language = 'en' end

local ConsoleRun, FileDirCreate, FileExists = RunConsoleCommand, file.CreateDir, file.Exists

if ( FileExists( 'ambi', 'DATA' ) == false ) then FileDirCreate( 'ambi' ) end -- checking on existence of a folder 
----------------------------------------------------------------------------------------------------

if game.SinglePlayer() then return end

timer.Simple( 2, function()
    local C = Ambi.General.Global.Colors
    http.Fetch( 'https://raw.githubusercontent.com/Titanovsky/ambi-eco/master/VERSION.md', function( sBody )
        if ( Ambi.version ~= sBody ) then
            for i = 1, 32 do 
                MsgC( C.ERROR, '\n|| [Ambi Eco] ||', C.ABS_WHITE, ' PLEASE, UPDATE NEW VERSION: ', C.AMBI_GREEN, sBody )
            end
            print( '\n' )
        end
    end )
end )