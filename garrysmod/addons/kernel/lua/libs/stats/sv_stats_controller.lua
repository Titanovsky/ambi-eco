AMB.Stats = AMB.Stats or {}
AMB.Stats.table = AMB.Stats.table or {

    [ 'health' ] = {

        set = function( eEntity, nAmount ) eEntity:SetHealth( nAmount ) end, 
        get = function( eEntity ) return eEntity:Health() end
    },

    [ 'armor' ] = {

        set = function( eEntity, nAmount ) eEntity:SetArmor( nAmount ) end, 
        get = function( eEntity ) return eEntity:Armor() end

    },

    [ 'maxspeed' ] = { 

        set = function( eEntity, nAmount ) eEntity:SetMaxSpeed( nAmount ) end, 
        get = function( eEntity ) return eEntity:GetMaxSpeed() end

    },

    [ 'walkspeed' ] = { 

        set = function( eEntity, nAmount ) eEntity:SetWalkSpeed( nAmount ) end, 
        get = function( eEntity ) return eEntity:GetWalkSpeed() end

    },

    [ 'runspeed' ] = { 

        set = function( eEntity, nAmount ) eEntity:SetRunSpeed( nAmount ) end, 
        get = function( eEntity ) return eEntity:GetRunSpeed() end

    }
}

function AMB.Stats.RegStats( sName, sType )

    sName = string.lower( sName )
    sType = string.lower( sType )

    if ( sType == 'string' ) then 
    
        AMB.Stats.table[ sName ] = { 

            set = function( eEntity, sArg ) eEntity:SetNWString( sName, sArg ) end,
            get = function( eEntity ) return eEntity:GetNWString( sName ) end,

        }

    elseif ( sType == 'int' ) then

        AMB.Stats.table[ sName ] = { 

            set = function( eEntity, nArg ) eEntity:SetNWInt( sName, nArg ) end,
            get = function( eEntity ) return eEntity:GetNWInt( sName ) end,

        }

    elseif ( sType == 'float' ) then

        AMB.Stats.table[ sName ] = {

            set = function( eEntity, nArg ) eEntity:SetNWFloat( sName, nArg ) end,
            get = function( eEntity ) return eEntity:GetNWFloat( sName ) end,

        }

    elseif ( sType == 'bool' ) then

        AMB.Stats.table[ sName ] = { 

            set = function( eEntity, bArg ) eEntity:SetNWBool( sName, bArg ) end,
            get = function( eEntity ) return eEntity:GetNWBool( sName ) end,

        }

    elseif ( sType == 'entity' ) then

        AMB.Stats.table[ sName ] = { 

            set = function( eEntity, eArg ) eEntity:SetNWEntity( sName, eArg ) end,
            get = function( eEntity ) return eEntity:GetNWEntity( sName ) end,

        }

    elseif ( sType == 'vector' ) then

        AMB.Stats.table[ sName ] = { 

            set = function( eEntity, vArg ) eEntity:SetNWVector( sName, vArg ) end,
            get = function( eEntity ) return eEntity:GetNWVector( sName ) end,

        }

    elseif ( sType == 'angle' ) then

        AMB.Stats.table[ sName ] = {

            set = function( eEntity, aArg ) eEntity:SetNWAngle( sName, aArg ) end,
            get = function( eEntity ) return eEntity:GetNWAngle( sName ) end,

        }

    else

        AMB.ErrorLog( 'Stats', 'Register Stats is Fail, unspecified type of data '..sType )

        return false
        
    end

    return true

end

function AMB.Stats.SetStats( eEntity, sStats, anyArg )

    sStats = string.lower( sStats )
    anyArg = anyArg or 0

    if not IsValid( eEntity ) then AMB.ErrorLog( 'Stats', 'Dont Set/Add Stats, not valid entity' ) return false end
    if not AMB.Stats.table[ sStats ] then AMB.ErrorLog( 'Stats', 'Dont Set/Add Stats, stats is not exists '..sStats ) return false end

    AMB.Stats.table[ sStats ].set( eEntity, anyArg )

    return true

end

function AMB.Stats.AddStats( eEntity, sStats, anyArg )

    anyArg = isbool( anyArg ) and 0 or anyArg
    if not AMB.Stats.GetStats( eEntity, sStats ) then AMB.ErrorLog( 'Stats', 'Dont AddStats, stats '..sStats..' not Get functions' ) return false end

    return AMB.Stats.SetStats( eEntity, sStats, AMB.Stats.GetStats( eEntity, sStats ) + anyArg )

end