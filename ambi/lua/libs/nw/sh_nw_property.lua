local tostring, isstring, isnumber, isbool, isvector, isangle, isentity = tostring, isstring, isnumber, isbool, isvector, isangle, isentity
local FMT = FindMetaTable
local METATABLES = {
    FMT( 'Entity' ), FMT( 'Player' ), FMT( 'Weapon' ), FMT( 'NPC' ), FMT( 'Vehicle' ), FMT( 'CSEnt' ), FMT( 'NextBot' )
}

if SERVER then
    local function EnableNWProperty( tMetatable ) -- SERVER
        local oldnewindex = tMetatable.__newindex

        tMetatable.__newindex = function( self, key, value )
            local _key = tostring( key or '' )

            if ( #_key > 3 ) and ( _key[ 1 ] == 'n' ) and ( _key[ 2 ] == 'w' ) and ( _key[ 3 ] == '_' ) then 
                _key = string.sub( _key, 4, #_key  )

                if isstring( value ) then self:SetNWString( _key, value ) end
                if isnumber( value ) then 
                    if ( value % 1 == 0 ) then self:SetNWInt( _key, value ) else self:SetNWFloat( _key, value ) end
                end
                if isbool( value ) then self:SetNWBool( _key, value ) end
                if isvector( value ) then self:SetNWVector( _key, value ) end
                if isangle( value ) then self:SetNWAngle( _key, value ) end
                if isentity( value ) then self:SetNWEntity( _key, value ) end
            end

            oldnewindex( self, key, value )
        end
    end

    for _, metatable in ipairs( METATABLES ) do EnableNWProperty( metatable ) end
else
    local cache = {}
    local types = {
        string = function( self, key ) return self:GetNWString( key, false ) end,
        int = function( self, key ) return self:GetNWInt( key, false ) end,
        float = function( self, key ) return self:GetNWFloat( key, false ) end,
        bool = function( self, key ) return self:GetNWBool( key, nil ) end,
        vector = function( self, key ) return self:GetNWVector( key, false ) end,
        angle = function( self, key ) return self:GetNWAngle( key, false ) end,
        entity = function( self, key ) return self:GetNWEntity( key, false ) end,
    }

    local function EnableNWProperty( tMetatable ) -- CLIENT
        local oldindex = tMetatable.__index

        tMetatable.__index = function( self, key )
            local _key = tostring( key or '' )

            if ( #_key > 3 ) and ( _key[ 1 ] == 'n' ) and ( _key[ 2 ] == 'w' ) and ( _key[ 3 ] == '_' ) then
                _key = string.sub( _key, 4, #_key  )

                local type = cache[ _key ]
                if type then return types[ type ]( self, _key ) end

                if ( self:GetNWInt( _key, false ) == false ) then else cache[ _key ] = 'int' return self:GetNWInt( key, nil ) end
                if ( self:GetNWFloat( _key, false ) == false ) then else cache[ _key ] = 'float' return self:GetNWFloat( key, nil ) end
                if ( self:GetNWString( _key, false ) == false ) then else cache[ _key ] = 'string' return self:GetNWString( key, nil ) end
                if ( self:GetNWBool( _key, nil ) == nil ) then else cache[ _key ] = 'bool' return self:GetNWBool( key, nil ) end
                if ( self:GetNWVector( _key, false ) == false ) then else cache[ _key ] = 'vector' return self:GetNWVector( key, nil ) end
                if ( self:GetNWAngle( _key, false ) == false ) then else cache[ _key ] = 'angle' return self:GetNWAngle( key, nil ) end
                if ( self:GetNWEntity( _key, false ) == false ) then else cache[ _key ] = 'entity' return self:GetNWEntity( key, nil ) end
            end
        
            return oldindex( self, key )
        end
    end

    for _, metatable in ipairs( METATABLES ) do EnableNWProperty( metatable ) end
end