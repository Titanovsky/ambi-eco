Ambi.JSON = Ambi.JSON or {}

local Gen = Ambi.General
local isstring, istable = isstring, istable
local In, Out = util.TableToJSON, util.JSONToTable

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.JSON.GetNiceTable( tData )
    if ( tData == nil ) then Gen.Error( 'JSON', 'GetNiceTable | tData is not exists!' ) return {} end
    if not istable( tData ) then Gen.Error( 'JSON', 'GetNiceTable | Type of sJSON is a table' ) return {} end

    for key, value in pairs( tData ) do
        if istable( value ) then
            local r, g, b = value.r, value.g, value.b
            if r and g and b then tData[ key ] = Color( r, g, b ) end
        end
    end

    return tData 
end

function Ambi.JSON.Serialize( tData, bPrint )
    if ( tData == nil ) then Gen.Error( 'JSON', 'Serialize | tData is not exists!' ) return {} end
    if isstring( tData ) then Gen.Error( 'JSON', 'Serialize | Type of tData is a table, maybe, mixed up JSON.Serialize with JSON.Deserialize' ) return {} end
    if ( istable( tData ) == false ) then Gen.Error( 'JSON', 'Serialize | type of tData is not a table!' ) return {} end

    return In( tData, bPrint or false ) --* Тут я решил сделать так, чтобы любое значение возвращало, это связанно с тем, чтобы запись/чтение файлов не прерывалось!
end

function Ambi.JSON.Deserialize( sJSON )
    if ( sJSON == nil ) then Gen.Error( 'JSON', 'Deserialize | sJSON is not exists!' ) return '' end
    if istable( sJSON ) then Gen.Error( 'JSON', 'Deserialize | Type of sJSON is a table, maybe, mixed up JSON.Deserialize with JSON.Serialize' ) return '' end
    if ( isstring( sJSON ) == false ) then Gen.Error( 'JSON', 'Deserialize | type of sJSON is not a string!' ) return '' end

    return Ambi.JSON.GetNiceTable( Out( sJSON ) ) --* Тут я решил сделать так, чтобы любое значение возвращало, это связанно с тем, чтобы запись/чтение файлов не прерывалось!
end

function Ambi.JSON.SerializeFile( tData, sPath )
    if not sPath then Gen.Error( 'JSON', 'SerializeFile | sPath not selected!' ) return {} end

    local json = Ambi.JSON.Serialize( tData )
    
    file.Write( sPath..'.json', json )

    return json
end

function Ambi.JSON.GetFile( sPath )
    if not sPath then Gen.Error( 'JSON', 'GetFile | sPath not selected!' ) return '' end

    local content = file.Read( sPath..'.json', 'DATA' )
    if not content then Gen.Error( 'JSON', 'GetFile | file '..sPath..'.json is not founded!' ) return '' end

    return content
end

function Ambi.JSON.DeserializeFile( sPath )
    if not sPath then Gen.Error( 'JSON', 'DeserializeFile | sPath not selected!' ) return '' end

    return Ambi.JSON.Deserialize( Ambi.JSON.GetFile( sPath ) )
end