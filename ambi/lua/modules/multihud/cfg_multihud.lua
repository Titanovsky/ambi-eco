Ambi.General.CreateModule( 'MultiHUD' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
Ambi.MultiHUD.Config.enable = true -- Включить/Выключить систему мульти-худов и ограничения для стандартного худа
Ambi.MultiHUD.Config.disable_target_id = true -- Отключить стандартную инфу игрока при наведений (ник и ХП)
Ambi.MultiHUD.Config.command = 'default' -- Консольная команда "ambi_hud_КОМАНДА" для смены худа, для каждого сервера должна быть уникальной, Например: ambi_hud_default, ambi_hud_rus
Ambi.MultiHUD.Config.default_id = 3 -- ID худа, когда у игрока впервые создаётся консольная команда (Заходи впервые на сервер)
Ambi.MultiHUD.Config.block = { -- Какие элементы не показывать?
    [ 'CHudHealth' ] = true,
    [ 'CHudBattery' ] = true,
    [ 'CHudAmmo' ] = true,
    [ 'CHudCrosshair' ] = false,
    [ 'CHudCloseCaption' ] = true,
    [ 'CHudDamageIndicator' ] = true,
    [ 'CHudHintDisplay' ] = true,
    [ 'CHudPoisonDamageIndicator' ] = false,
    [ 'CHudSecondaryAmmo' ] = true,
    [ 'CHudSuitPower' ] = true,
    [ 'CHudHintDisplay' ] = true,
    [ 'CHudChat' ] = false,
}