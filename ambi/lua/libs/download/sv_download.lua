Ambi.Download = Ambi.Download or {}

-- -------------------------------------------------------------------------------------
local Gen = Ambi.General
local resource, print = resource, print
-- -------------------------------------------------------------------------------------

Ambi.Download.snd_dir = 'sound/'
Ambi.Download.mat_dir = 'materials/'
Ambi.Download.mdl_dir = 'models/'
Ambi.Download.map_dir = 'maps/'
Ambi.Download.res_dir = 'resource/'
Ambi.Download.fonts_dir = 'resource/fonts/'

local convert_type_data = {
    [ 0 ] = Ambi.Download.snd_dir,
    [ 'sounds' ] = Ambi.Download.snd_dir,
    [ 'sound' ] = Ambi.Download.snd_dir,
    [ 'snd' ] = Ambi.Download.snd_dir,

    [ 1 ] = Ambi.Download.fonts_dir,
    [ 'fonts' ] = Ambi.Download.fonts_dir,
    [ 'font' ] = Ambi.Download.fonts_dir,

    [ 2 ] = Ambi.Download.mat_dir,
    [ 'materials' ] = Ambi.Download.mat_dir,
    [ 'material' ] = Ambi.Download.mat_dir,
    [ 'mat' ] = Ambi.Download.mat_dir,

    [ 3 ] = Ambi.Download.mdl_dir,
    [ 'models' ] = Ambi.Download.mdl_dir,
    [ 'model' ] = Ambi.Download.mdl_dir,
    [ 'mdl' ] = Ambi.Download.mdl_dir,

    [ 4 ] = Ambi.Download.map_dir,
    [ 'maps' ] = Ambi.Download.map_dir,
    [ 'map' ] = Ambi.Download.map_dir,

    [ 5 ] = Ambi.Download.res_dir,
    [ 'resources' ] = Ambi.Download.res_dir,
    [ 'resource' ] = Ambi.Download.res_dir,
    [ 'res' ] = Ambi.Download.res_dir
}

function Ambi.Download.ConvertTypeData( sTypeData ) 
    if convert_type_data[ sTypeData ] then
        return convert_type_data[ sTypeData ]
    else
        Gen.Error( 'Download', 'Not exist type of data: '..sTypeData )

        return ''
    end
end

function Ambi.Download.Load( sMethod, sTypeData, sString )
    local dir = Ambi.Download.ConvertTypeData( sTypeData or '' )

    sString = dir..sString

    Ambi.OnDebug( function() print( sString ) end )

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

-- Ambi.Download.Load( 'file', 'sound', 'basewars/music/fukkierta.mp3' ) -- file: sound/basewars/music/fukkierta.mp3