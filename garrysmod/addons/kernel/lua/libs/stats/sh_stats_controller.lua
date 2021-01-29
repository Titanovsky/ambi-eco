AMB.Stats = AMB.Stats or {}

function AMB.Stats.GetStats( eEntity, sStats, sType )

    sStats = string.lower( sStats )

    --if not AMB.Stats.table[ sStats ] then AMB.ErrorLog( 'Stats', 'Dont Get non existent value: '..sStats ) return false end

    if not IsValid( eEntity ) or not isentity( eEntity ) then AMB.ErrorLog( 'Stats', 'Not exists entity '..tostring( eEntity ) ) return false end

    if AMB.Stats.table[ sStats ] and AMB.Stats.table[ sStats ].get( eEntity ) then return AMB.Stats.table[ sStats ].get( eEntity ) end

    if ( sType == 'string' ) then return eEntity:GetNWString( sStats )
    elseif ( sType == 'int' ) then return eEntity:GetNWInt( sStats )
    elseif ( sType == 'float' ) then return eEntity:GetNWFloat( sStats )
    elseif ( sType == 'bool' ) then return eEntity:GetNWBool( sStats )
    elseif ( sType == 'entity' ) then return eEntity:GetNWEntity( sStats )
    elseif ( sType == 'vector' ) then return eEntity:GetNWVector( sStats )
    elseif ( sType == 'angle' ) then return eEntity:GetNWAngle( sStats )
    else return false
    end

end

function AMB.Stats.GetTable()

    return AMB.Stats.table

end

function AMB.Stats.PrintTable()

    PrintTable( AMB.Stats.table )

end