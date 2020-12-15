AMB.Stats = AMB.Stats or {}
AMB.Stats.table = {

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

} or {}

function AMB.Stats.GetStats( eEntity, sStats )

    sStats = string.lower( sStats )

    if not AMB.Stats.table[ sStats ] then AMB.ErrorLog( 'Stats', 'Dont Get non existent value: '..sStats ) return false end

    if not IsValid( eEntity ) or not isentity( eEntity ) then AMB.ErrorLog( 'Stats', 'Not exists entity '..tostring( eEntity ) ) return false end

    return AMB.Stats.table[ sStats ].get( eEntity )

end

function AMB.Stats.GetTable()

    return AMB.Stats.table

end

function AMB.Stats.PrintTable()

    PrintTable( AMB.Stats.table )

end