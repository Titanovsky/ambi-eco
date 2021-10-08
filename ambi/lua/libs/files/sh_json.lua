Ambi.Files.JSON = AMB.Files.JSON or {}

local Gen = Ambi.General
local util, isstring, istable = util, isstring, istable

-- Тут я решил сделать так, чтобы любое значение возвращало, это связанно с тем, чтобы запись/чтение файлов не прерывалось!

function Ambi.Files.JSON.In( tData, bPrint )
    if ( tData == nil ) then Gen.Error( 'Files.JSON', 'In | tData is not exists!' ) return {} end
    if isstring( tData ) then Gen.Error( 'Files.JSON', 'In | Type of tData is a table, maybe, mixed up JSON.In with JSON.Out' ) return {} end
    if ( istable( tData ) == false ) then Gen.Error( 'Files.JSON', 'In | type of tData is not a table!' ) return {} end

    return util.TableToJSON( tData, bPrint or false )
end

function Ambi.Files.JSON.Out( sJSON )
    if ( sJSON == nil ) then Gen.Error( 'Files.JSON', 'Out | sJSON is not exists!' ) return '' end
    if istable( sJSON ) then Gen.Error( 'Files.JSON', 'Out | Type of sJSON is a table, maybe, mixed up JSON.Out with JSON.In' ) return '' end
    if ( isstring( sJSON ) == false ) then Gen.Error( 'Files.JSON', 'Out | type of sJSON is not a string!' ) return '' end

    return util.JSONToTable( sJSON )
end