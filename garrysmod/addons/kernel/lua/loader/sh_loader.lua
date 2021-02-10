AMB.Loader = AMB.Loader or {}
AMB.Loader.files = AMB.Loader.files or {}
AMB.Loader.modules = AMB.Loader.modules or {}
AMB.Loader.libraries = AMB.Loader.libraries or {}

local current_files = {}

local file = file
local string = string
local print = print
local pairs = pairs
local include = include
local AddCSLuaFile = AddCSLuaFile

local function InitFile( sName, sFlag )

    sFlag = string.Explode( '_', sFlag )
    local tag = sFlag[ 1 ]

    if ( tag == 'cfg' ) or ( tag == 'sh' ) or ( tag == 'npc' ) or ( tag == 'ent' ) or ( tag == 'wep' ) or ( tag == 'veh' ) then

        include( sName )
        AddCSLuaFile( sName )

    elseif ( tag == 'sv' ) then

        if SERVER then include( sName ) end

    elseif ( tag == 'cl' ) then

        if SERVER then AddCSLuaFile( sName ) elseif CLIENT then include( sName ) end

    elseif ( tag == 'id' ) then

        local ID = sFlag[ 2 ]

        resource.AddWorkshop( ID )

        AMB.Debug( function() print( '[DEBUG] Added workshop ['..ID..']' ) end )

    end

end

local function LoadFiles( sDirectory )

    local name = 'modules/'..sDirectory

    local files, directories = file.Find( name..'/*', 'LUA' )

    for _, v in pairs( files ) do

        AMB.Loader.files[ #AMB.Loader.files + 1 ] = sDirectory..'/'..v
        current_files[ #current_files + 1 ] = sDirectory..'/'..v
        InitFile( 'modules/'..sDirectory..'/'..v , v )

    end

    if ( #directories > 0 ) then
            
        for _, v in pairs( directories ) do

            LoadFiles( sDirectory..'/'..v )

        end

    end

    return AMB.Loader.files

end

local function LoadFilesLibs( sLib )

    local name = 'libs/'..sLib

    local files, directories = file.Find( name..'/*', 'LUA' )

    for _, v in pairs( files ) do

        InitFile( name..'/'..v , string.Left( v, 3 ) )

    end

    if ( #directories > 0 ) then
            
        for k, v in pairs( directories ) do

            LoadFilesLibs( sLib..'/'..v )

        end

    end

end

function AMB.Loader.ConnectMicroKernel()

    local _, directories = file.Find( 'libs/*', 'LUA' )

    for id, name in pairs( directories ) do

        AMB.Loader.libraries[ id ] = name
        LoadFilesLibs( name )

    end

    if not SERVER then return end

    AMB.Debug( function() 
    
        print( '[DEBUG] List of Libraries: ' )
        PrintTable( AMB.Loader.libraries )

    end )

end

function AMB.Loader.ConnectModule( sName, sDescription )

    LoadFiles( sName )

    if not SERVER then return end

    sDescription = sDescription or ''

    print( '[KERNEL] ['..string.upper( sName )..'] - '..sDescription )

    AMB.Debug( function() 
    
        print( '[DEBUG] ['..string.upper( sName )..'] List of Files: ' )
        PrintTable( current_files )

    end )

    print( '\n' )

    current_files = {}

end