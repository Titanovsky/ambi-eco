AMB.UI.HUD = AMB.UI.HUD or {}
AMB.UI.HUD.table = AMB.UI.HUD.table or {}

AMB.UI.HUD.convar = 'amb_hud_'..AMB.Config.prefix
AMB.UI.HUD.enable = false

AMB.UI.HUD.block_elements = {

    [ 'CHudHealth' ] = true,
    [ 'CHudBattery' ] = true,
    [ 'CHudAmmo' ] = true,
    [ 'CHudCrosshair' ] = false,
    [ 'CHudCloseCaption' ] = true,
    [ 'CHudDamageIndicator' ] = true,
    [ 'CHudHintDisplay' ] = true,
    [ 'CHudPoisonDamageIndicator' ] = true,
    [ 'CHudSecondaryAmmo' ] = true,
    [ 'CHudSuitPower' ] = true,
    [ 'CHudHintDisplay' ] = true

}

function AMB.UI.HUD.RegisterHUD( nID, sName, sAuthor, fDraw )

    AMB.UI.HUD.table[ nID ] = {
            
        name = sName,
        author = sAuthor,
        draw = fDraw

    }

end

function AMB.UI.HUD.EnableLibrary( bEnable )

    AMB.UI.HUD.enable = bEnable

    if bEnable then

        CreateClientConVar( 'amb_hud_'..AMB.Config.prefix, 0, true )

        hook.Add( 'HUDShouldDraw', 'AMB.UI.HUD.DontDrawHL2HUD', function( sElement ) return not AMB.UI.HUD.block_elements[ sElement ] end )
        hook.Add( 'HUDDrawTargetID', 'AMB.UI.HUD.DontDrawTargetID', function() return false end )
        hook.Add( 'HUDPaint', 'AMB.UI.HUD.DrawCustomHUD', function()

            local HUD = AMB.UI.HUD.table[ GetConVar( AMB.UI.HUD.convar ):GetInt() ]
            if not HUD then HUD = AMB.UI.HUD.table[ 1 ] end

            HUD.draw() 
            
        end )


    else

        hook.Remove( 'HUDPaint', 'AMB.UI.HUD.DrawCustomHUD' )
        hook.Remove( 'HUDShouldDraw', 'AMB.UI.HUD.DontDrawHL2HUD' )
        hook.Remove( 'HUDDrawTargetID', 'AMB.UI.HUD.DontDrawTargetID' )
        
    end

    return bEnable

end

function AMB.UI.HUD.GetTable()

    return AMB.UI.HUD.table

end