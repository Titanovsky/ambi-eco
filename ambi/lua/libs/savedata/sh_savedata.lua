Ambi.SaveData = Ambi.SaveData or {}
Ambi.SaveData.tables = Ambi.SaveData.tables or {}

local Gen = Ambi.General
local isstring, istable, ipairs = isstring, istable, ipairs
local In, Out = util.TableToJSON, util.JSONToTable
local Write, Read, CreateDir, Exists = file.Write, file.Read, file.CreateDir, file.Exists
local Lower, Explode = string.lower, string.Explode

local PATH = 'ambi/savedata/'

-- ---------------------------------------------------------------------------------------------------------------------------------------
--* From JSON library
local function JSON_GetNiceTable( tData )
    for key, value in pairs( tData ) do
        if istable( value ) then
            local r, g, b = value.r, value.g, value.b
            if r and g and b then tData[ key ] = Color( r, g, b ) end
        end
    end

    return tData 
end

local function JSON_Serialize( tData, bPrint )
    return In( tData, bPrint or false ) 
end

local function JSON_Deserialize( sJSON )
    return JSON_GetNiceTable( Out( sJSON ) )
end

local function JSON_SerializeFile( tData, sPath )
    Write( sPath..'.json', JSON_Serialize( tData ) )
end

local function JSON_GetFile( sPath )
    return Read( sPath..'.json', 'DATA' )
end

local function JSON_DeserializeFile( sPath )
    return JSON_Deserialize( JSON_GetFile( sPath ) )
end

local function CheckEqualTable( ... )
    local tables = { ... }

    local len

    for i = 1, #tables do
        local tab = tables[ i ]
        local next_tab = tables[ i + 1 ]

        local current_len = 0 
        for key, value in pairs( tab ) do
            current_len = current_len + 1
            if next_tab and ( next_tab[ key ] ~= value ) then return false end
        end

        if len then
            if ( current_len ~= len ) then return false end
        else
            len = current_len
        end
    end

    return true
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
CreateDir( PATH )

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.SaveData.Create( sNameDataBase, tKeysValues )
    if not sNameDataBase or not isstring( sNameDataBase ) then Gen.Error( 'SaveData', 'sNameDataBase == nil or isn\'t a string' ) return end

    local db_name = Lower( sNameDataBase )
    local path = PATH..db_name

    local tab = {}
    tab.data = {}
    tab.default = tKeysValues

    if Ambi.SaveData.tables[ db_name ] then
        if CheckEqualTable( Ambi.SaveData.tables[ db_name ].default, tKeysValues ) then return db_name end

        Ambi.SaveData.tables[ db_name ].default = tKeysValues

        hook.Call( '[Ambi.SaveData.UpdatedKeys]', nil, db_name, Ambi.SaveData.tables[ db_name ], tKeysValues )

        Ambi.SaveData.Save( sNameDataBase )

        return db_name
    else
        if JSON_GetFile( path ) then 
            local tab = JSON_DeserializeFile( path )
            if not tab then return end -- todo errors

            Ambi.SaveData.tables[ db_name ] = tab

            return db_name
        end
    end

    Ambi.SaveData.tables[ db_name ] = tab

    hook.Call( '[Ambi.SaveData.Created]', nil, db_name, tab, tKeysValues )

    Ambi.SaveData.Save( sNameDataBase )

    return db_name
end

function Ambi.SaveData.CreateBackup( sNameDataBase )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local path = PATH..db_name..'.backup'

    JSON_SerializeFile( db, path )

    hook.Call( '[Ambi.SaveData.CreatedBackup]', nil, db_name )
end

function Ambi.SaveData.RestoreBackup( sNameDataBase )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error 

    local path = PATH..db_name..'.backup'

    if not JSON_GetFile( path ) then return end -- todo error
    
    local data = JSON_DeserializeFile( path )
    if not data then return end -- todo errors

    Ambi.SaveData.tables[ db_name ] = data

    hook.Call( '[Ambi.SaveData.RestoredBackup]', nil, db_name, data )

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.Init( sNameDataBase, tKeys, bSetDefault )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    db.data[ #db.data + 1 ] = bSetDefault and db.default or {}
    local data = db.data[ #db.data ]

    for key, value in pairs( tKeys ) do
        data[ key ] = value
    end

    hook.Call( '[Ambi.SaveData.Initialized]', nil, db_name, data, tKeys, bSetDefault )

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.Set( sNameDataBase, tKeys, tValues )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local len_keys = 0
    for _, __ in pairs( tKeys ) do
        len_keys = len_keys + 1
    end

    for i = 1, #db.data do
        local data = db.data[ i ]
        local success = 0

        for key, key_id in pairs( tKeys ) do
            if ( data[ key ] == key_id ) then success = success + 1 end

            if ( success == len_keys ) then
                for key, value in pairs( tValues ) do
                    data[ key ] = value

                    hook.Call( '[Ambi.SaveData.Set]', nil, db_name, data, tKeys, tValues )

                    Ambi.SaveData.Save( db_name )
                end
            end
        end
    end
end

function Ambi.SaveData.SetByIndex( sNameDataBase, nIndex, tValues )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local data = db.data[ nIndex ]
    if not data then return end

    for key, value in pairs( tValues ) do
        data[ key ] = value
    end

    hook.Call( '[Ambi.SaveData.SetByIndex]', nil, db_name, data, nIndex, tValues )

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.SetDefault( sNameDataBase )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local default = db.default

    for i, data in ipairs( db.data ) do
        for key, value in pairs( default ) do
            if not data[ key ] then data[ key ] = value end
        end
    end

    hook.Call( '[Ambi.SaveData.SetDefault]', nil, db_name, db )

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.Remove( sNameDataBase, tKeys )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local len = 0
    for _, __ in pairs( tKeys ) do
        len = len + 1
    end

    local for_removes = {}

    for i = 1, #db.data do
        local data = db.data[ i ]
        local success = 0

        for key, value in pairs( tKeys ) do
            if ( data[ key ] == value ) then
                success = success + 1

                if ( success == len ) then 
                    for_removes[ #for_removes + 1 ] = i
                end
            end
        end
    end

    if ( #for_removes == 0 ) then return end

    for i = #for_removes, 1, -1 do -- it's should be a reverse
        table.remove( db.data, for_removes[ i ] )

        hook.Call( '[Ambi.SaveData.Removed]', nil, db_name, db.data[ for_removes[ i ] ] )
    end

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.Wipe( sNameDataBase, bSetDefault )
    local db_name = Lower( sNameDataBase )

    if bSetDefault then
        local db = Ambi.SaveData.tables[ db_name ]
        if not db then return end -- todo error

        local default = db.default
        
        for i, data in pairs( db.data ) do
            for key, value in pairs( default ) do
                data[ key ] = value
            end
        end
    else
        Ambi.SaveData.tables[ db_name ].data = {}
    end

    hook.Call( '[Ambi.SaveData.Wiped]', nil, db_name, Ambi.SaveData.tables[ db_name ].data )

    Ambi.SaveData.Save( db_name )
end

function Ambi.SaveData.Save( sNameDataBase )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end

    local path = PATH..db_name

    JSON_SerializeFile( db, path )

    hook.Call( '[Ambi.SaveData.Saved]', nil, db_name, Ambi.SaveData.tables[ db_name ] )
end

function Ambi.SaveData.Get( sNameDataBase, tKeys )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local get_tables = {}

    local len = 0
    for _, __ in pairs( tKeys ) do
        len = len + 1
    end

    for i, data in ipairs( db.data ) do
        local success = 0

        for key, value in pairs( tKeys ) do
            if ( data[ key ] == value ) then success = success + 1 end

            if ( success == len ) then
                get_tables[ #get_tables + 1 ] = data
            end
        end
    end

    local len = #get_tables
    if ( len == 0 ) then return elseif ( len == 1 ) then get_tables = get_tables[ 1 ] end -- workaround

    return get_tables
end

function Ambi.SaveData.GetData( sNameDataBase, nIndex )
    local db_name = Lower( sNameDataBase )
    local data = Ambi.SaveData.tables[ db_name ].data 

    return nIndex and data[ nIndex ] or data
end

function Ambi.SaveData.GetDefault( sNameDataBase )
    return Ambi.SaveData.tables[ Lower( sNameDataBase ) ].default
end

function Ambi.SaveData.GetTables()
    return Ambi.SaveData.tables
end

function Ambi.SaveData.IsValid( sNameDataBase, tKeys, fSuccess, fFail )
    local tab = Ambi.SaveData.Get( sNameDataBase, tKeys )
    
    if tab and fSuccess then 
        fSuccess( tab )
    elseif not tab and fFail then 
        fFail()
    end
end

function Ambi.SaveData.FindValuesByKeys( sNameDataBase, tKeys )
    local db_name = Lower( sNameDataBase )
    local db = Ambi.SaveData.tables[ db_name ]
    if not db then return end -- todo error

    local get_tables = {}

    for i, data in ipairs( db.data ) do
        for j, key in ipairs( tKeys ) do
            if data[ key ] then
                if not get_tables[ i ] then get_tables[ i ] = {} end
                get_tables[ i ][ key ] = data[ key ]
            end
        end
    end

    return get_tables
end