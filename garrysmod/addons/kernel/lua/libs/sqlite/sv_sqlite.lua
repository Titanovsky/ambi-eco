AMB.SQL = AMB.SQL or {}

local sql = sql
local isstring = isstring
local ipairs = ipairs
local unpack = unpack
local Format = Format
local setmetatable = setmetatable

local closure = ";"

local function EnableThreadErrors()

    -- from Official Wiki, auto print of errors https://wiki.facepunch.com/gmod/sql.LastError
    sql.m_strError = nil

    local meta = {}
    meta.__newindex = function( _, sKey, sValueError ) 

        if ( sKey == 'm_strError' ) and sValueError then AMB.ErrorLog( 'SQL', sValueError ) end 
        
    end

    setmetatable( sql, meta )

end
EnableThreadErrors()

function AMB.SQL.CreateTable( sName, sVars )

    if sql.TableExists( sName ) or not sVars then return sName end

    sql.Query( "CREATE TABLE "..sName.."("..sVars..")"..closure )

    AMB.ConsoleLog( 'SQLite', 'Database '..sName..' created!' )

    return sName

end

function AMB.SQL.GetTable( sName )

    if sql.TableExists( sName ) then return sName end

    return false

end

function AMB.SQL.DropTable( sName )

    if not sql.TableExists( sName ) then AMB.ErrorLog( 'SQL', 'Dosent DROP the table '..sName ) return false end

    sql.Query( "DROP TABLE "..sName..closure )

    return true

end

function AMB.SQL.TruncateTable( sName )

    if not sql.TableExists( sName ) then AMB.ErrorLog( 'SQL', 'Dosent TRUNCATE the table '..sName ) return false end

    sql.Query( "TRUNCATE TABLE "..sName..closure )

    return true

end

function AMB.SQL.Str( anyObject, bNoQuotes )

    return sql.SQLStr( anyObject, bNoQuotes )

end

function AMB.SQL.Select( sTable, sKey, sIDKey, anyIDValue )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent SELECT the table '..sTable ) return false end

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    return sql.QueryValue( "SELECT "..sKey.." FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue..closure ) 

end

function AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue )

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if sql.QueryValue( "SELECT "..sKey.." FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue..closure ) then return true end

    return false

end

function AMB.SQL.SelectAll( sTable )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent SELECT ALL the table '..sTable ) return false end

    local db = sql.Query( "SELECT * FROM "..sTable..closure )

    return db and db or false

end

function AMB.SQL.Insert( sTable, sKeys, sFormats, ... )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent INSERT in the table '..sTable ) return false end

    local values = { ... }

    for k, v in ipairs( values ) do
        
        if isstring( v ) then values[ k ] = AMB.SQL.Str( v ) end

    end

    local formated_values = Format( sFormats, unpack( values ) )

    sql.QueryValue( "INSERT INTO "..sTable.."("..sKeys..") VALUES("..formated_values..")"..closure )

    return true

end

function AMB.SQL.AutoInsert( sTable, ... ) -- TODO

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent SELECT the table '..sTable ) return false end

    local values = { ... }
    local keys = {} -- from sTable
    local formats = {} -- from types values

    return true

    -- Insert, but auto search sKeys and sFormats

end

function AMB.SQL.Update( sTable, sKey, anyValue, sIDKey, anyIDValue )

    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE in the table '..sTable ) return false end

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue.." WHERE "..sIDKey.."="..anyIDValue..closure )

    return true

end

function AMB.SQL.UpdateDouble( sTable, sKey, anyValue, sIDKey, anyIDValue, sIDKey2, anyIDValue2 )

    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end
    if isstring( anyIDValue2 ) then anyIDValue2 = AMB.SQL.Str( anyIDValue2 ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE in the table '..sTable ) return false end

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue.." WHERE "..sIDKey.."="..anyIDValue.." AND "..sIDKey2..'='..anyIDValue2..closure )

    return true

end

function AMB.SQL.UpdateAll( sTable, sKey, anyValue )

    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE ALL the table '..sTable ) return false end

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue..closure )

    return true

end

function AMB.SQL.Delete( sTable, sIDKey, anyIDValue )

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE ALL the table '..sTable ) return false end

    sql.Query( "DELETE FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue..closure )

    return true

end

function AMB.SQL.Get( sTable, sKey, sIDKey, anyIDValue, fSuccess, fError )

    if AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue ) then return fSuccess() end

    return fError()

end