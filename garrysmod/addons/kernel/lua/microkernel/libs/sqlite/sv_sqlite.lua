AMB.SQL = AMB.SQL or {}

local sql = sql
local isstring = isstring
local ipairs = ipairs
local unpack = unpack
local Format = Format

function AMB.SQL.CreateTable( sName, sVars )

    if sql.TableExists( sName ) then return sName end

    sql.Query( "CREATE TABLE "..sName.."("..sVars..")" )

    AMB.ConsoleLog( 'SQLite', 'Database '..sName..' created!' )

    return sName

end

function AMB.SQL.DropTable( sName )

    if not sql.TableExists( sName ) then AMB.ErrorLog( 'SQL', 'Dosent DROP the table '..sName ) return false end

    sql.Query( "DROP TABLE "..sName )

    return true

end

function AMB.SQL.Str( anyObject, bNoQuotes )

    return sql.SQLStr( anyObject, bNoQuotes )

end

function AMB.SQL.Select( sTable, sKey, sIDKey, anyIDValue )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent SELECT the table '..sTable ) return false end

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    return sql.QueryValue( "SELECT "..sKey.." FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue ) 

end

function AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue )

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if sql.QueryValue( "SELECT "..sKey.." FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue ) then return true end

    return false

end

function AMB.SQL.SelectAll( sTable )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent SELECT ALL the table '..sTable ) return false end

    return sql.Query( "SELECT * FROM "..sTable ) 

end

function AMB.SQL.Insert( sTable, sKeys, sFormats, ... )

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent INSERT in the table '..sTable ) return false end

    local values = { ... }

    for k, v in ipairs( values ) do
        
        if isstring( v ) then values[ k ] = AMB.SQL.Str( v ) end

    end

    local formated_values = Format( sFormats, unpack( values ) )

    sql.QueryValue( "INSERT INTO "..sTable.."("..sKeys..") VALUES("..formated_values..")" )

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

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue.." WHERE "..sIDKey.."="..anyIDValue )

end

function AMB.SQL.Update2( sTable, sKey, anyValue, sIDKey, anyIDValue, sIDKey2, anyIDValue2 )

    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end
    if isstring( anyIDValue2 ) then anyIDValue2 = AMB.SQL.Str( anyIDValue2 ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE2 in the table '..sTable ) return false end

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue.." WHERE "..sIDKey.."="..anyIDValue.." AND "..sIDKey2..'='..anyIDValue2 )

end

function AMB.SQL.UpdateAll( sTable, sKey, anyValue )

    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE ALL the table '..sTable ) return false end

    sql.Query( "UPDATE "..sTable.." SET "..sKey.."="..anyValue )

end

function AMB.SQL.Delete( sTable, sIDKey, anyIDValue )

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if not sql.TableExists( sTable ) then AMB.ErrorLog( 'SQL', 'Dosent UPDATE ALL the table '..sTable ) return false end

    sql.Query( "DELETE FROM "..sTable.." WHERE "..sIDKey.."="..anyIDValue )

    return true

end

function AMB.SQL.Get( sTable, sKey, sIDKey, anyIDValue, fSuccess, fError )

    if AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue ) then return fSuccess() end

    return fError()

end

-- # From Wiki ############
sql.m_strError = nil
setmetatable(sql, { __newindex = function( table, key, value )
	if k == "m_strError" and v then
		print("[SQL Error] " .. v )
	end
end } )
-- #########################