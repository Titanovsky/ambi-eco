Ambi.Configurator.exceptions = Ambi.Configurator.exceptions or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Configurator.AddException( sModule, sKey, sHeader ) 
    if not sModule or not sKey or not sHeader then return end

    Ambi.Configurator.exceptions[ sModule ] = Ambi.Configurator.exceptions[ sModule ] or {} 
    Ambi.Configurator.exceptions[ sModule ][ sKey ] = sHeader
end

function Ambi.Configurator.RemoveException( sModule, sKey )
    if not sModule or not sKey then return end

    if Ambi.Configurator.exceptions[ sModule ] then Ambi.Configurator.exceptions[ sModule ][ sKey ] = nil end
end

function Ambi.Configurator.AddConfigFile( sNameDirectoryOfModule )
    --TODO
end

--TODO сделать добавление/удаление ключей в таблице (отдельное меню)
--TODO добавить парсер с конфиг файла
--TODO сделать строку состояния и передавать в неё данные
--TODO сделать переключение ключей в таблице (на 2 странице) в особые названия через конвары
--TODO сделать Сохранение/Загрузку конфига с json и статус сохранения