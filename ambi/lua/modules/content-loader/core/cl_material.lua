Ambi.ContentLoader.materials = Ambi.ContentLoader.materials or {}

local C = Ambi.Packages.Out( 'colors' )
local Material, CRC, Fetch = Material, util.CRC, http.Fetch
local DEFAULT_MATERIAL = Material( 'icon16/error.png' ) -- placeholder for error got nil

-- --------------------------------------------------------------------------------------------------------------------------------------------
if not file.Exists( 'ambi/content-loader', 'DATA' ) then
    file.CreateDir( 'ambi/content-loader' )
    MsgC( C.PURPLE, '\n[ContentLoader] ', C.WHITE, 'The directory has created.' )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.ContentLoader.CreateDir( sDir )
    file.CreateDir( 'ambi/content-loader/'..sDir )
end

function Ambi.ContentLoader.DownloadMaterial( sTag, sPath, sURL, nAttempts )
    nAttempts = nAttempts or 1

    if ( nAttempts > Ambi.ContentLoader.Config.material_tries ) then 
        if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material was not created and tries are lost: ', C.AMBI_RED, sPath ) end

        Ambi.ContentLoader.materials[ sTag ] = nil
        if not Ambi.ContentLoader.materials then Ambi.ContentLoader.materials = {} end

        return 
    end

    if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material prepare to download: ', C.AMBI_SOFT_YELLOW, sPath, C.AMBI_WHITE, ' ['..nAttempts..']' ) end

    local path = 'ambi/content-loader/'..sPath

    Ambi.ContentLoader.materials[ sTag ] = Ambi.ContentLoader.materials[ sTag ] or {
        path = path,
        url = sUrl,
        crc_url_body = '',
        material = Material( '' ),
        attempts = nAttempts,
        ready_attempt = 0,
    }

    Fetch( sURL, function( sBody, nSize, _, nCode ) 
        if not Ambi.ContentLoader.materials[ sTag ] then return end
        if ( nCode == 500 ) then
            if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'The link is wrong with ', C.RED, sPath, C.WHITE, ' code: ', C.AMBI_RED, nCode ) end

            if file.Exists( path, 'DATA' ) then  
                MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Materials was got from ', C.AMBI_GREEN, sPath )
                
                Ambi.ContentLoader.materials[ sTag ].material = nil
                Ambi.ContentLoader.materials[ sTag ].material = Material( '../data/'..path, 'clamp smooth' )
                Ambi.ContentLoader.materials[ sTag ].material:GetTexture( '$basetexture' ):Download()
            else
                Ambi.ContentLoader.materials[ sTag ] = nil
                if not Ambi.ContentLoader.materials then Ambi.ContentLoader.materials = {} end
            end 

            return 
        end

        if file.Exists( path, 'DATA' ) then 
            local crc, crc_url_body = CRC( file.Read( path, 'DATA' ) ), CRC( sBody )

            Ambi.ContentLoader.materials[ sTag ].crc = crc
            Ambi.ContentLoader.materials[ sTag ].crc_url_body = crc_url_body

            if ( crc == crc_url_body ) then 
                if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'CRC File is equal CRC Body: ', C.AMBI_GREEN, sPath ) end

                Ambi.ContentLoader.materials[ sTag ].material = nil
                Ambi.ContentLoader.materials[ sTag ].material = Material( '../data/'..path, 'clamp smooth' )
                Ambi.ContentLoader.materials[ sTag ].material:GetTexture( '$basetexture' ):Download()

                if Ambi.ContentLoader.materials[ sTag ].material:IsError() then  
                    if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material was wrong created and try: ', C.AMBI_RED, sPath ) end

                    timer.Simple( Ambi.ContentLoader.Config.material_delay, function()
                        Ambi.ContentLoader.DownloadMaterial( sTag, sPath, sURL, nAttempts + 1 )
                    end )

                    return 
                else
                    -- ! win result here
                    if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material was created on '..nAttempts..' attempts: ', C.AMBI_GREEN, sPath ) end

                    Ambi.ContentLoader.materials[ sTag ].ready_attempt = nAttempts

                    return
                end
            else
                if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'CRC File is not equal CRC Body: ', C.AMBI_RED, sPath ) end

                file.Delete( path )

                if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material was deleted and try: ', C.AMBI_RED, sPath ) end

                timer.Simple( Ambi.ContentLoader.Config.material_delay, function()
                    Ambi.ContentLoader.DownloadMaterial( sTag, sPath, sURL, nAttempts + 1 )
                end )
            end
        end

        file.Write( path, sBody )

        if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'Material is writing and try: ', C.AMBI_SOFT_YELLOW, sPath ) end

        timer.Simple( Ambi.ContentLoader.Config.material_delay, function()
            Ambi.ContentLoader.DownloadMaterial( sTag, sPath, sURL, nAttempts + 1 )
        end )
    end, function( sCode ) 
        if Ambi.ContentLoader.Config.material_log then MsgC( C.AMBI_SOFT_YELLOW, '\n[ContentLoader] ', C.WHITE, 'The link is wrong with "'..sCode..'" code: ', C.AMBI_RED, sPath ) end

        if file.Exists( path, 'DATA' ) then  
            Ambi.ContentLoader.materials[ sTag ].material = nil
            Ambi.ContentLoader.materials[ sTag ].material = Material( '../data/'..path, 'clamp smooth' )
            Ambi.ContentLoader.materials[ sTag ].material:GetTexture( '$basetexture' ):Download()

            return 
        end 

        Ambi.ContentLoader.materials[ sTag ] = nil
        if not Ambi.ContentLoader.materials then Ambi.ContentLoader.materials = {} end

        return 
    end )
end

function Ambi.ContentLoader.Material( sTag )
    return Ambi.ContentLoader.materials[ sTag ] and Ambi.ContentLoader.materials[ sTag ].material or DEFAULT_MATERIAL
end

function Ambi.ContentLoader.GetMaterials()
    return Ambi.ContentLoader.materials
end