Ambi.JSON = Ambi.JSON or {}

local Gen = Ambi.General
local isstring, istable = isstring, istable
local In, Out = util.TableToJSON, util.JSONToTable

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.JSON.Format( sJSON )
    if ( sJSON == nil ) then Gen.Error( 'JSON', 'Format | sJSON is not exists!' ) return '' end

    --todo

    return sJSON 
end

function Ambi.JSON.In( tData, bPrint )
    if ( tData == nil ) then Gen.Error( 'JSON', 'In | tData is not exists!' ) return {} end
    if isstring( tData ) then Gen.Error( 'JSON', 'In | Type of tData is a table, maybe, mixed up JSON.In with JSON.Out' ) return {} end
    if ( istable( tData ) == false ) then Gen.Error( 'JSON', 'In | type of tData is not a table!' ) return {} end

    return In( tData, bPrint or false ) --* Тут я решил сделать так, чтобы любое значение возвращало, это связанно с тем, чтобы запись/чтение файлов не прерывалось!
end

function Ambi.JSON.Out( sJSON )
    if ( sJSON == nil ) then Gen.Error( 'JSON', 'Out | sJSON is not exists!' ) return '' end
    if istable( sJSON ) then Gen.Error( 'JSON', 'Out | Type of sJSON is a table, maybe, mixed up JSON.Out with JSON.In' ) return '' end
    if ( isstring( sJSON ) == false ) then Gen.Error( 'JSON', 'Out | type of sJSON is not a string!' ) return '' end

    return Out( sJSON ) --* Тут я решил сделать так, чтобы любое значение возвращало, это связанно с тем, чтобы запись/чтение файлов не прерывалось!
end