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
        local full_name = ''

        if ( #sFlag > 2 ) then

            for k, str in ipairs( sFlag ) do

                if ( str == 'id' ) or ( str == ID ) then continue end

                str = string.SetChar( str, 1, string.upper( string.sub( str, 1, 1 ) ) )

                local margin = ( k == #sFlag ) and '' or ' '

                full_name = full_name..str..margin

            end

        end

        AMB.Debug( function() print( '[DEBUG] [MODULES] Added workshop ['..ID..'] ['..full_name..']' ) end )

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

function AMB.Loader.ConnectResourceWorkshopFromAddons()

    AMB.Debug( function() print( '[DEBUG] [ADDONS] Initialize connection WorkshopID' ) end )

    local _, directories = file.Find( 'addons/*', 'GAME' )

    for _, dir in pairs( directories ) do

        local files, _ = file.Find( 'addons/'..dir..'/*', 'GAME' )

        for _, file in pairs( files ) do

            if not string.StartWith( string.lower( file ), 'id' ) then continue end

            local name = string.Explode( '_', file )
            local ID = name[ 2 ]
            local full_name = ''

            if ( #name > 2 ) then

                for k, str in ipairs( name ) do

                    if ( str == 'id' ) or ( str == ID ) then continue end

                    str = string.SetChar( str, 1, string.upper( string.sub( str, 1, 1 ) ) )

                    local margin = ( k == #name ) and '' or ' '

                    full_name = full_name..str..margin

                end

            end

            resource.AddWorkshop( ID )

            AMB.Debug( function() print( '[DEBUG] [ADDONS] Added workshop ['..ID..'] ['..full_name..']' ) end )

        end

    end

end