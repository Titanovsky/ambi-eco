AMB.Download = AMB.Download or {}

-- -------------------------------------------------------------------------------------
local A = AMB.Ambition
local resource, print = resource, print
-- -------------------------------------------------------------------------------------

AMB.Download.snd_dir = 'sound/ambition/'
AMB.Download.mat_dir = 'materials/ambition/'
AMB.Download.mdl_dir = 'models/ambition/'
AMB.Download.map_dir = 'maps/'
AMB.Download.res_dir = 'resource/ambition/'
AMB.Download.fonts_dir = 'resource/fonts/'

local convert_type_data = {
    [ 0 ] = AMB.Download.snd_dir,
    [ 'sounds' ] = AMB.Download.snd_dir,
    [ 'sound' ] = AMB.Download.snd_dir,
    [ 'snd' ] = AMB.Download.snd_dir,

    [ 1 ] = AMB.Download.fonts_dir,
    [ 'fonts' ] = AMB.Download.fonts_dir,
    [ 'font' ] = AMB.Download.fonts_dir,

    [ 2 ] = AMB.Download.mat_dir,
    [ 'materials' ] = AMB.Download.mat_dir,
    [ 'material' ] = AMB.Download.mat_dir,
    [ 'mat' ] = AMB.Download.mat_dir,

    [ 3 ] = AMB.Download.mdl_dir,
    [ 'models' ] = AMB.Download.mdl_dir,
    [ 'model' ] = AMB.Download.mdl_dir,
    [ 'mdl' ] = AMB.Download.mdl_dir,

    [ 4 ] = AMB.Download.map_dir,
    [ 'maps' ] = AMB.Download.map_dir,
    [ 'map' ] = AMB.Download.map_dir,

    [ 5 ] = AMB.Download.res_dir,
    [ 'resources' ] = AMB.Download.res_dir,
    [ 'resource' ] = AMB.Download.res_dir,
    [ 'res' ] = AMB.Download.res_dir
}

function AMB.Download.ConvertTypeData( sTypeData ) 
    if convert_type_data[ sTypeData ] then
        return convert_type_data[ sTypeData ]
    else
        A.Error( 'Download', 'Not exist type of data: '..sTypeData )

        return ''
    end
end

function AMB.Download.Load( sMethod, sTypeData, sString )
    local dir = AMB.Download.ConvertTypeData( sTypeData or '' )

    sString = dir..sString

    A.OnDebug( function() print( sString ) end )

    if ( sMethod == 'workshop' ) then 
        resource.AddWorkshop( sString )
        print( '[Download] Added Workshop: '..sString )
    elseif ( sMethod == 'single_file' ) then 
        resource.AddSingleFile( sString ) 
        print( '[Download] Added ('..sTypeData..') Single Ffile: '..sString )
    else
        resource.AddFile( sString )
        print( '[Download] Added ('..sTypeData..') File: '..sString )
    end
end

-- AMB.Download.Load( 'file', 'sound', 'basewars/music/fukkierta.mp3' ) -- directory: sound/ambition