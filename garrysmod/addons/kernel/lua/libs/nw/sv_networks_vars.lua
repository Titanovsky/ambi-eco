AMB.NW = AMB.NW or {}

function AMB.NW.Set( eEntity, sStats, anyValue, sType )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.Set on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.Set' ) return false end
    if not sType or not isstring( sType ) then AMB.ErrorLog( 'NW', 'Non correct sType for NW.Set' ) return false end

    if ( sType == 'string' ) or ( sType == 's' ) or ( sType == 'String' ) then return eEntity:SetNWString( sStats, anyValue )
    elseif ( sType == 'int' ) or ( sType == 'i' ) or ( sType == 'Int' ) then return eEntity:SetNWInt( sStats, anyValue )
    elseif ( sType == 'float' ) or ( sType == 'f' ) or ( sType == 'Float' ) then return eEntity:SetNWFloat( sStats, anyValue )
    elseif ( sType == 'bool' ) or ( sType == 'b' ) or ( sType == 'Bool' ) then return eEntity:SetNWBool( sStats, anyValue )
    elseif ( sType == 'entity' ) or ( sType == 'e' ) or ( sType == 'Entity' ) then return eEntity:SetNWEntity( sStats, anyValue )
    elseif ( sType == 'vector' ) or ( sType == 'v' ) or ( sType == 'Vector' ) then return eEntity:SetNWVector( sStats, anyValue )
    elseif ( sType == 'angle' ) or ( sType == 'a' ) or ( sType == 'Angle' ) then return eEntity:SetNWAngle( sStats, anyValue )
    else AMB.ErrorLog( 'NW', 'Unknow type '..sType..' for NW.Set' ) return false
    end

end

function AMB.NW.Add( eEntity, sStats, anyValue, sType )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.Add on not valid Entity' ) return false end
    if not anyValue then AMB.ErrorLog( 'NW', 'Non correct anyValue for NW.Add' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.Add' ) return false end
    if not sType or not isstring( sType ) then AMB.ErrorLog( 'NW', 'Non correct sType for NW.Add' ) return false end

    if ( sType == 'int' ) or ( sType == 'i' ) or ( sType == 'Int' ) then return eEntity:SetNWInt( sStats, eEntity:GetNWInt( sStats ) + anyValue )
    elseif ( sType == 'float' ) or ( sType == 'f' ) or ( sType == 'Float' )  then return eEntity:SetNWFloat( sStats, eEntity:GetNWFloat( sStats ) + anyValue )
    elseif ( sType == 'vector' ) or ( sType == 'v' ) or ( sType == 'Vector' )  then return eEntity:SetNWVector( sStats, eEntity:GetNWVector( sStats ) + anyValue )
    elseif ( sType == 'angle' ) or ( sType == 'a' ) or ( sType == 'Angle' )  then return eEntity:SetNWAngle( sStats, eEntity:GetNWAngle( sStats ) + anyValue )
    else AMB.ErrorLog( 'NW', 'Unknow type '..sType..' for NW.Add' ) return false
    end

end

-- Specific: String
function AMB.NW.SetString( eEntity, sStats, sValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetString on not valid Entity' ) return false end
    if not sValue then AMB.ErrorLog( 'NW', 'Non correct sValue for NW.SetString' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetString' ) return false end

    return eEntity:SetNWString( sStats, sValue )

end
-- Specific: Int
function AMB.NW.SetInt( eEntity, sStats, iValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetInt on not valid Entity' ) return false end
    if not iValue then AMB.ErrorLog( 'NW', 'Non correct iValue for NW.SetInt' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetInt' ) return false end

    return eEntity:SetNWInt( sStats, iValue )

end

function AMB.NW.AddInt( eEntity, sStats, iValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.AddInt on not valid Entity' ) return false end
    if not iValue then AMB.ErrorLog( 'NW', 'Non correct iValue for NW.AddInt' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.AddInt' ) return false end

    return eEntity:SetNWInt( sStats, eEntity:GetNWInt( sStats ) + iValue )

end
-- Specific: Float
function AMB.NW.SetFloat( eEntity, sStats, nValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetFloat on not valid Entity' ) return false end
    if not nValue then AMB.ErrorLog( 'NW', 'Non correct nValue for NW.SetFloat' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetFloat' ) return false end

    return eEntity:SetNWFloat( sStats, nValue )

end

function AMB.NW.AddFloat( eEntity, sStats, nValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.AddFloat on not valid Entity' ) return false end
    if not nValue then AMB.ErrorLog( 'NW', 'Non correct nValue for NW.AddFloat' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.AddFloat' ) return false end

    return eEntity:SetNWFloat( sStats, eEntity:GetNWFloat( sStats ) + nValue )

end
-- Specific: Bool
function AMB.NW.SetBool( eEntity, sStats, bValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetBool on not valid Entity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetBool' ) return false end

    return eEntity:SetNWBool( sStats, bValue )

end
-- Specific: Entity
function AMB.NW.SetEntity( eEntity, sStats, eValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetEntity on not valid Entity' ) return false end
    if not eValue then AMB.ErrorLog( 'NW', 'Non correct eValue for NW.SetEntity' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetEntity' ) return false end

    return eEntity:SetNWEntity( sStats, eValue )

end
-- Specific: Vector
function AMB.NW.SetVector( eEntity, sStats, vValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetVector on not valid Entity' ) return false end
    if not vValue then AMB.ErrorLog( 'NW', 'Non correct vValue for NW.SetVector' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetVector' ) return false end

    return eEntity:SetNWVector( sStats, vValue )

end

function AMB.NW.AddVector( eEntity, sStats, vValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.AddVector on not valid Entity' ) return false end
    if not vValue then AMB.ErrorLog( 'NW', 'Non correct vValue for NW.AddVector' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.AddVector' ) return false end

    return eEntity:SetNWVector( sStats, eEntity:GetNWVector( sStats ) + vValue )

end
-- Specific: Angle
function AMB.NW.SetAngle( eEntity, sStats, aValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.SetAngle on not valid Entity' ) return false end
    if not aValue then AMB.ErrorLog( 'NW', 'Non correct aValue for NW.SetAngle' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.SetAngle' ) return false end

    return eEntity:SetNWAngle( sStats, aValue )

end

function AMB.NW.AddAngle( eEntity, sStats, aValue )

    if not IsValid( eEntity ) then AMB.ErrorLog( 'NW', 'Cannot use NW.AddAngle on not valid Entity' ) return false end
    if not aValue then AMB.ErrorLog( 'NW', 'Non correct aValue for NW.AddAngle' ) return false end
    if not sStats or not isstring( sStats ) then AMB.ErrorLog( 'NW', 'Non correct sStats for NW.AddAngle' ) return false end

    return eEntity:SetNWAngle( sStats, eEntity:GetNWAngle( sStats ) + aValue )

end

