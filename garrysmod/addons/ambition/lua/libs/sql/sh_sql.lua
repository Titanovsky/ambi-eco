AMB.SQL = AMB.SQL or {}

-- -------------------------------------------------------------------------------------
local A = AMB.Ambition
local sql, isstring, ipairs, unpack, Format, setmetatable = sql, isstring, ipairs, unpack, Format, setmetatable
local TableExists, Query, QueryValue, SQLStr = sql.TableExists, sql.Query, sql.QueryValue, sql.SQLStr
-- -------------------------------------------------------------------------------------

function AMB.SQL.CreateTable( sName, sVars )
    if TableExists( sName ) or not sVars then return sName end

    sql.Query( 'CREATE TABLE '..sName..'('..sVars..');' )
    print( 'SQLite', 'Database '..sName..' created' )

    return sName
end

function AMB.SQL.ValidTable( sTable )
    return TableExists( sTable )
end

function AMB.SQL.DropTable( sName )
    if not TableExists( sName ) then A.Error( 'SQL', 'Can\'t to drop the unexistent table '..sName ) return false end

    Query( 'DROP TABLE '..sName..';' )

    return true
end

function AMB.SQL.Str( anyObject, bNoQuotes )
    return SQLStr( anyObject, bNoQuotes )
end

function AMB.SQL.Select( sTable, sKey, sIDKey, anyIDValue )
    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to select the unexistent table '..sTable ) return false end

    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    return QueryValue( 'SELECT '..sKey..' FROM '..sTable..' WHERE '..sIDKey..'='..anyIDValue..';' ) 
end

function AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue )
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if QueryValue( 'SELECT '..sKey..' FROM '..sTable..' WHERE '..sIDKey..'='..anyIDValue..';' ) then return true end

    return false
end

function AMB.SQL.SelectAll( sTable )
    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to select all the unexistent table '..sTable ) return false end

    local db = sql.Query( 'SELECT * FROM '..sTable..';' )

    return db and db or false
end

function AMB.SQL.Insert( sTable, sKeys, sFormats, ... )
    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to insert in the unexistent table '..sTable ) return false end

    local values = { ... }
    for k, v in ipairs( values ) do
        if isstring( v ) then values[ k ] = AMB.SQL.Str( v ) end
    end

    local formated_values = Format( sFormats, unpack( values ) )
    QueryValue( 'INSERT INTO '..sTable..'('..sKeys..') VALUES('..formated_values..');' )

    return true
end

function AMB.SQL.AutoInsert( sTable, ... ) -- TODO
    if not sql.TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to auto insert in the unexistent table '..sTable ) return false end

    local values = { ... }
    local keys = {} -- from sTable
    local formats = {} -- from types values

    return true

    -- Insert, but auto search sKeys and sFormats
end

function AMB.SQL.Update( sTable, sKey, anyValue, sIDKey, anyIDValue )
    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if not TableExists( sTable ) then A.Error( 'SQL', 'Dosent UPDATE in the table '..sTable ) return false end

    Query( 'UPDATE '..sTable..' SET '..sKey..'='..anyValue..' WHERE '..sIDKey..'='..anyIDValue..';' )

    return true
end

function AMB.SQL.UpdateDouble( sTable, sKey, anyValue, sIDKey, anyIDValue, sIDKey2, anyIDValue2 )
    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end
    if isstring( anyIDValue2 ) then anyIDValue2 = AMB.SQL.Str( anyIDValue2 ) end

    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to update double the unexistent table '..sTable ) return false end

    Query( 'UPDATE '..sTable..' SET '..sKey..'='..anyValue..' WHERE '..sIDKey..'='..anyIDValue..' AND '..sIDKey2..'='..anyIDValue2..';' )

    return true
end

function AMB.SQL.UpdateAll( sTable, sKey, anyValue )
    if isstring( anyValue ) then anyValue = AMB.SQL.Str( anyValue ) end

    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to update all the unexistent table '..sTable ) return false end

    Query( 'UPDATE '..sTable..' SET '..sKey..'='..anyValue..';' )

    return true
end

function AMB.SQL.Delete( sTable, sIDKey, anyIDValue )
    if isstring( anyIDValue ) then anyIDValue = AMB.SQL.Str( anyIDValue ) end

    if not TableExists( sTable ) then A.Error( 'SQL', 'Can\'t to delete the unexistent table '..sTable ) return false end

    Query( 'DELETE FROM '..sTable..' WHERE '..sIDKey..'='..anyIDValue..';' )

    return true
end

function AMB.SQL.Get( sTable, sKey, sIDKey, anyIDValue, fSuccess, fError )
    if AMB.SQL.IsSelect( sTable, sKey, sIDKey, anyIDValue ) then return fSuccess() end

    return fError()
end

function AMB.SQL.EnableThreadErrors()
    -- from Official Wiki, auto print of errors https://wiki.facepunch.com/gmod/sql.LastError
    if CLIENT then return end
    sql.m_strError = nil

    local meta = {}
    meta.__newindex = function( _, sKey, sValueError ) 
        if ( sKey == 'm_strError' ) and sValueError then A.Error( 'SQL', sValueError ) end 
    end

    setmetatable( sql, meta )
end