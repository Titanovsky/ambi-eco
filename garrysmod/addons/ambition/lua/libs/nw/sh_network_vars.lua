AMB.NW = AMB.NW or {}

function AMB.NW.Get( eEntity, sStats, sType )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.Get on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.Get' ) return false end
    if not sType or not isstring( sType ) then AMB.ErrorLog( 'NW', 'Non correct sType for NW.Get' ) return false end

    if ( sType == 'string' ) or ( sType == 's' ) or ( sType == 'String' ) then return eEntity:GetNWString( sStats ) or false
    elseif ( sType == 'int' ) or ( sType == 'i' ) or ( sType == 'Int' ) then return eEntity:GetNWInt( sStats ) or false
    elseif ( sType == 'float' ) or ( sType == 'f' ) or ( sType == 'Float' ) then return eEntity:GetNWFloat( sStats ) or false
    elseif ( sType == 'bool' ) or ( sType == 'b' ) or ( sType == 'Bool' ) then return eEntity:GetNWBool( sStats ) or false
    elseif ( sType == 'entity' ) or ( sType == 'e' ) or ( sType == 'Entity' ) then return eEntity:GetNWEntity( sStats ) or false
    elseif ( sType == 'vector' ) or ( sType == 'v' ) or ( sType == 'Vector' ) then return eEntity:GetNWVector( sStats ) or false
    elseif ( sType == 'angle' ) or ( sType == 'a' ) or ( sType == 'Angle' ) then return eEntity:GetNWAngle( sStats ) or false
    else return false
    end

end

function AMB.NW.GetString( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetString on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetString' ) return false end

    return eEntity:GetNWString( sStats ) or false

end

function AMB.NW.GetInt( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetInt on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetInt' ) return false end

    return eEntity:GetNWInt( sStats ) or false

end

function AMB.NW.GetFloat( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetFloat on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetFloat' ) return false end

    return eEntity:GetNWFloat( sStats ) or false

end

function AMB.NW.GetBool( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetBool on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetBool' ) return false end

    return eEntity:GetNWBool( sStats ) or false

end

function AMB.NW.GetEntity( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetEntity on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetEntity' ) return false end

    return eEntity:GetNWEntity( sStats ) or false

end

function AMB.NW.GetVector( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetVector on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetVector' ) return false end

    return eEntity:GetNWVector( sStats ) or false

end

function AMB.NW.GetAngle( eEntity, sStats )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.GetAngle on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.GetAngle' ) return false end

    return eEntity:GetNWAngle( sStats ) or false

end
