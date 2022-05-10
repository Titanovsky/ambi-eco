Ambi.Base = Ambi.Base or {}
Ambi.Base.Config = Ambi.Base.Config or {}

-- ----------------------------------------------------------------------------------------------------------------------------------------
Ambi.Base.Config.configurator_enable = true -- TODO

-- ----------------------------------------------------------------------------------------------------------------------------------------
Ambi.Base.Config.download_content_from_urls = true -- Включить систему закачки контента (Иконок, звуков, материалов и т.д) сразу при заходе TODO

-- ----------------------------------------------------------------------------------------------------------------------------------------
Ambi.Base.Config.fonts_max_size = 128 -- До какого размера шрифты будут созданы (Не рекомендую больше 128)

-- ----------------------------------------------------------------------------------------------------------------------------------------
Ambi.Base.Config.hud_enable = true -- Включить систему мульти-худов
Ambi.Base.Config.hud_disable_target_id = true -- Отключить стандартную инфу игрока при наведений (ник и ХП)
Ambi.Base.Config.hud_command = 'hud' -- Консольная команда ambi_КОМАНДА для смены худа (Например, ambi_hud)
Ambi.Base.Config.hud_id = 1 -- ID худа, когда у игрока впервые создаётся консольная команда
Ambi.Base.Config.hud_block = { -- Какие элементы блочить всегда?
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
}

-- ----------------------------------------------------------------------------------------------------------------------------------------
Ambi.Base.Config.disable_render_on_hasnt_focus = true -- Отключать рендер, когда у игрока запущена игра, но она свернута?