AMB.NW = AMB.NW or {}

function AMB.NW.Set( eEntity, sStats, anyValue, sType )

    if CLIENT then return end

    if ( sType == 'string' ) or ( sType == 's' ) or ( sType == 'String' ) then return eEntity:SetNWString( sStats, anyValue )
    elseif ( sType == 'int' ) or ( sType == 'i' ) or ( sType == 'Int' ) then return eEntity:SetNWInt( sStats, anyValue )
    elseif ( sType == 'float' ) or ( sType == 'f' ) or ( sType == 'Float' ) then return eEntity:SetNWFloat( sStats, anyValue )
    elseif ( sType == 'bool' ) or ( sType == 'b' ) or ( sType == 'Bool' ) then return eEntity:SetNWBool( sStats, anyValue )
    elseif ( sType == 'entity' ) or ( sType == 'e' ) or ( sType == 'Entity' ) then return eEntity:SetNWEntity( sStats, anyValue )
    elseif ( sType == 'vector' ) or ( sType == 'v' ) or ( sType == 'Vector' ) then return eEntity:SetNWVector( sStats, anyValue )
    elseif ( sType == 'angle' ) or ( sType == 'a' ) or ( sType == 'Angle' ) then return eEntity:SetNWAngle( sStats, anyValue )
    else return false
    end

end

function AMB.NW.Add( eEntity, sStats, anyValue, sType )

    if CLIENT then return end

    if ( sType == 'int' ) or ( sType == 'i' ) or ( sType == 'Int' ) then return eEntity:SetNWInt( sStats, eEntity:GetNWInt( sStats ) + anyValue )
    elseif ( sType == 'float' ) or ( sType == 'f' ) or ( sType == 'Float' )  then return eEntity:SetNWFloat( sStats, eEntity:GetNWFloat( sStats ) + anyValue )
    elseif ( sType == 'vector' ) or ( sType == 'v' ) or ( sType == 'Vector' )  then return eEntity:SetNWVector( sStats, eEntity:GetNWVector( sStats ) + anyValue )
    elseif ( sType == 'angle' ) or ( sType == 'a' ) or ( sType == 'Angle' )  then return eEntity:SetNWAngle( sStats, eEntity:GetNWAngle( sStats ) + anyValue )
    else return false
    end

end

function AMB.NW.Get( eEntity, sStats, sType )

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

-- Specific: Int

function AMB.NW.SetInt( eEntity, sStats, nValue )

    if CLIENT then return end

    return eEntity:SetNWInt( sStats, nValue )

end

function AMB.NW.AddInt( eEntity, sStats, nValue )

    if CLIENT then return end

    return eEntity:SetNWInt( sStats, eEntity:GetNWInt( sStats ) + nValue )

end

function AMB.NW.GetInt( eEntity, sStats )

    return eEntity:GetNWInt( sStats ) or false

end

-- Specific: Float
-- Specific: String
-- Specific: Bool
-- Specific: Entity
-- Specific: Vector
-- Specific: Angle

