AMB.Loader = AMB.Loader or {}
AMB.Loader.modules = AMB.Loader.modules or {}
AMB.Loader.libraries = AMB.Loader.libraries or {}

local file = file
local string = string
local print = print
local pairs = pairs
local include = include
local AddCSLuaFile = AddCSLuaFile

local function InitFile( sName, sFlag )

    if ( sFlag == 'sh_' ) then

        include( sName )
        AddCSLuaFile( sName )

    elseif ( sFlag == 'sv_' ) then

        if SERVER then include( sName ) end

    elseif ( sFlag == 'cl_' ) then

        if SERVER then AddCSLuaFile( sName ) elseif CLIENT then include( sName ) end

    end

end

local function LoadFiles( sDirectory )

    local name = 'modules/'..sDirectory

    local files, directories = file.Find( name..'/*', 'LUA' )

    for _, v in pairs( files ) do

        AMB.Loader.modules[ #AMB.Loader.modules + 1 ] = sDirectory..'/'..v
        InitFile( 'modules/'..sDirectory..'/'..v , string.Left( v, 3 ) )

    end

    if ( #directories > 0 ) then
            
        for _, v in pairs( directories ) do

            LoadFiles( sDirectory..'/'..v )

        end

    end

    return AMB.Loader.modules

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
    
        print( '[Debug] List of Libraries: ' )
        PrintTable( AMB.Loader.libraries )

    end )

end

function AMB.Loader.ConnectModule( sName, sDescription )

    LoadFiles( sName )

    if not SERVER then return end

    sDescription = sDescription or ''

    print( '[Kernel] Module '..sName..' | '..sDescription )

    AMB.Debug( function() 
    
        print( '[Debug] List of Modules: ' )
        PrintTable( AMB.Loader.modules )

    end )

end