AMB.Downloads = AMB.Downloads or {}

local resource = resource

AMB.Downloads.snd_dir = 'sound/ambition/'
AMB.Downloads.mat_dir = 'materials/ambition/'
AMB.Downloads.mdl_dir = 'models/ambition/'
AMB.Downloads.map_dir = 'maps/'
AMB.Downloads.res_dir = 'resource/ambition/'
AMB.Downloads.fonts_dir = 'resource/fonts/'

local convert_type_data = {
    
    [ 'sounds' ] = AMB.Downloads.snd_dir,
    [ 'sound' ] = AMB.Downloads.snd_dir,
    [ 'snd' ] = AMB.Downloads.snd_dir,

    [ 'fonts' ] = AMB.Downloads.fonts_dir,
    [ 'font' ] = AMB.Downloads.fonts_dir,

    [ 'materials' ] = AMB.Downloads.mat_dir,
    [ 'material' ] = AMB.Downloads.mat_dir,
    [ 'mat' ] = AMB.Downloads.mat_dir,

    [ 'models' ] = AMB.Downloads.mdl_dir,
    [ 'model' ] = AMB.Downloads.mdl_dir,
    [ 'mdl' ] = AMB.Downloads.mdl_dir,

    [ 'maps' ] = AMB.Downloads.map_dir,
    [ 'map' ] = AMB.Downloads.map_dir,

    [ 'resources' ] = AMB.Downloads.res_dir,
    [ 'resource' ] = AMB.Downloads.res_dir,
    [ 'res' ] = AMB.Downloads.res_dir

}

function AMB.Downloads.ConvertTypeData( sTypeData ) 

    if convert_type_data[ sTypeData ] then

        return convert_type_data[ sTypeData ]

    else

        AMB.ErrorLog( 'Downloads | Not exist type of data: '..sTypeData )

        return ''

    end

end

function AMB.Downloads.Load( sMethod, sTypeData, sString )


    local dir = AMB.Downloads.ConvertTypeData( sTypeData )

    sString = dir..sString

    AMB.Debug( function() print( sString ) end )

    if ( sMethod == 'workshop' ) then 
    
        resource.AddWorkshop( sString )

        AMB.ConsoleLog( '[Downloads] Added Workshop: '..sString )

    elseif ( sMethod == 'single_file' ) then 
    
        resource.AddSingleFile( sString ) 

        AMB.ConsoleLog( '[Downloads] Added ('..sTypeData..') Single Ffile: '..sString )

    else
    
        resource.AddFile( sString )

        AMB.ConsoleLog( '[Downloads] Added ('..sTypeData..') File: '..sString )
        
    end

end

-- AMB.Downloads.Load( 'file', 'sound', 'basewars/music/fukkierta.mp3' ) -- directory: sound/ambition