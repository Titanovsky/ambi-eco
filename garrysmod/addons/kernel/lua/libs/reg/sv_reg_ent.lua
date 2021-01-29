AMB.RegisterEntities = AMB.RegisterEntities or {}
AMB.RegisterEntities.ConfigEnts = AMB.RegisterEntities.ConfigEnts or {}

AMB.RegisterEntities.ConfigEnts.mdl = 'models/props_c17/chair02a.mdl'
AMB.RegisterEntities.ConfigEnts.mat = ''
AMB.RegisterEntities.ConfigEnts.col = Color( 255, 255, 255 )
AMB.RegisterEntities.ConfigEnts.mvt = MOVETYPE_VPHYSICS
AMB.RegisterEntities.ConfigEnts.phi = SOLID_VPHYSICS
AMB.RegisterEntities.ConfigEnts.enm = true

function AMB.RegisterEntities.InitEntity( ent, sModel, sMat, cColor, nUseType, bDropToFloor, nRenderMode )

    ent:SetModel( sModel or AMB.RegisterEntities.ConfigEnts.mdl )
    ent:SetMaterial( sMat or AMB.RegisterEntities.ConfigEnts.mat )
    ent:SetColor( cColor or AMB.RegisterEntities.ConfigEnts.col )
    ent:SetUseType( nUseType or SIMPLE_USE )
    if bDropToFloor then ent:DropToFloor() end

    return ent

end

function AMB.RegisterEntities.PhysicsEntity( ent, nMoveType, nPhysicInit, bEnableMotion )

    ent:SetMoveType( nMoveType or AMB.RegisterEntities.ConfigEnts.mvt )
    ent:PhysicsInit( nPhysicInit or AMB.RegisterEntities.ConfigEnts.phi )

    local phys = ent:GetPhysicsObject()
    if IsValid( phys ) then 
    
        phys:Wake()
        phys:EnableMotion( bEnableMotion or AMB.RegisterEntities.ConfigEnts.enm ) 
        
    end

    return phys

end