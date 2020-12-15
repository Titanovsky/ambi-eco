AMB.UI.HUD = AMB.UI.HUD or {}
AMB.UI.HUD.table = AMB.UI.HUD.table or {}

AMB.UI.HUD.convar = 'amb_hud'
AMB.UI.HUD.block_elements = {

    [ 'CHudHealth' ] = true,
    [ 'CHudBattery' ] = true,
    [ 'CHudAmmo' ] = true,
    [ 'CHudCrosshair' ] = true,
    [ 'CHudCloseCaption' ] = true,
    [ 'CHudDamageIndicator' ] = true,
    [ 'CHudHintDisplay' ] = true,
    [ 'CHudPoisonDamageIndicator' ] = true,
    [ 'CHudSecondaryAmmo' ] = true,
    [ 'CHudSuitPower' ] = true,
    [ 'CHudHintDisplay' ] = true

}

CreateClientConVar( AMB.UI.HUD.convar, '0', true )

function AMB.UI.HUD.RegisterHUD( nID, sName, sAuthor, fDraw )

    AMB.UI.HUD.table[ nID ] = {

        name = sName,
        author = sAuthor,
        hud = fDraw

    }

end

function AMB.UI.HUD.GetTable()

    return AMB.UI.HUD.table

end
AMB.UI.HUD.RegisterHUD( 0, 'DisableHUD', '[ Ambition ]', function() end )

hook.Add( 'HUDPaint', 'AMB.UI.HUD.DrawCustomHUD', function() AMB.UI.HUD.table[ GetConVar( AMB.UI.HUD.convar ):GetInt() ].hud() end )
hook.Add( 'HUDShouldDraw', 'AMB.UI.HUD.DontDrawHL2HUD', function( sElement ) return not AMB.UI.HUD.block_elements[ sElement ] end )
hook.Add( 'HUDDrawTargetID', 'AMB.UI.HUD.DontDrawTargetID', function() return false end )
