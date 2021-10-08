local PLAYER = FindMetaTable( 'Player' )

if SERVER then
    local oldnewindex = PLAYER.__newindex

    PLAYER.__newindex = function( self, key, value )
        --if not value then return end
        local _key = tostring( key or '' )

        if string.StartWith( _key, 'nw_' ) then 
            if isnumber( value ) then self:SetNWInt( _key, value ) end
        end

        oldnewindex( self, key, value )
    end
else
    local cache = {}
    local oldindex = PLAYER.__index
    local types = {
        string = function( self, key ) return self:GetNWString( key ) end,
        int = function( self, key ) return self:GetNWInt( key ) end,
        float = function( self, key ) return self:GetNWFloat( key ) end,
        bool = function( self, key ) return self:GetNWBool( key ) end,
        vector = function( self, key ) return self:GetNWVector( key ) end,
        angle = function( self, key ) return self:GetNWAngle( key ) end,
        entity = function( self, key ) return self:GetNWEntity( key ) end,
    }

    PLAYER.__index = function( self, key )
        local _key = tostring( key or '' )

        if ( #_key > 3 ) and ( _key[ 1 ] == 'n' ) and ( _key[ 2 ] == 'w' ) and ( _key[ 3 ] == '_' ) then
            local type = cache[ _key ]
            if type then return types[ type ]( self, _key ) end

            if ( self:GetNWString( _key, false ) == false ) then else cache[ _key ] = 'string' return self:GetNWString( key ) end
            if ( self:GetNWInt( _key, false ) == false ) then else cache[ _key ] = 'int' return self:GetNWInt( key ) end
            if ( self:GetNWFloat( _key, false ) == false ) then else cache[ _key ] = 'float' return self:GetNWFloat( key ) end
            if ( self:GetNWBool( _key, nil ) == nil ) then else cache[ _key ] = 'bool' return self:GetNWBool( key ) end
            if ( self:GetNWVector( _key, false ) == false ) then else cache[ _key ] = 'vector' return self:GetNWVector( key ) end
            if ( self:GetNWAngle( _key, false ) == false ) then else cache[ _key ] = 'angle' return self:GetNWAngle( key ) end
            if ( self:GetNWEntity( _key, false ) == false ) then else cache[ _key ] = 'entity' return self:GetNWEntity( key ) end
        end
    
        return oldindex( self, key )
    end
end