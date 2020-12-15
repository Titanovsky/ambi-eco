AMB.RegisterEntities = AMB.RegisterEntities or {}
AMB.RegisterEntities.ConfigNPCs = AMB.RegisterEntities.ConfigNPCs or {}

AMB.RegisterEntities.ConfigNPCs.mdl = 'models/gman_high.mdl'
AMB.RegisterEntities.ConfigNPCs.mat = ''
AMB.RegisterEntities.ConfigNPCs.col = Color( 255, 255, 255 )
AMB.RegisterEntities.ConfigNPCs.rnm = RENDERMODE_NORMAL
AMB.RegisterEntities.ConfigNPCs.ust = SIMPLE_USE

AMB.RegisterEntities.ConfigNPCs.mvt = MOVETYPE_NONE
AMB.RegisterEntities.ConfigNPCs.phi = SOLID_BBOX
AMB.RegisterEntities.ConfigNPCs.enm = false

AMB.RegisterEntities.ConfigNPCs.hlt = HULL_HUMAN

function AMB.RegisterEntities.InitNPC( ent, sModel, sMat, cColor, nUseType, bDropToFloor, nRenderMode )

    ent:SetModel( sModel or AMB.RegisterEntities.ConfigNPCs.mdl )
    ent:SetMaterial( sMat or AMB.RegisterEntities.ConfigNPCs.mat )
    ent:SetColor( cColor or AMB.RegisterEntities.ConfigNPCs.col )
    ent:SetRenderMode( nRenderMode or AMB.RegisterEntities.ConfigNPCs.rnm )
    ent:SetUseType( nUseType or AMB.RegisterEntities.ConfigNPCs.ust )
    if bDropToFloor then ent:DropToFloor() end
    
    return ent

end

function AMB.RegisterEntities.BehaviorNPC( ent, nHullType )

    ent:SetHullType( nHullType or AMB.RegisterEntities.ConfigNPCs.hlt )
	ent:SetHullSizeNormal()

    return ent

end

function AMB.RegisterEntities.CapabilityNPC( ent, nCap )

    ent:CapabilitiesAdd( nCap )

    return ent

end

function AMB.RegisterEntities.PhysicsNPC( ent, nMoveType, nPhysicInit, bEnableMotion )

    ent:SetMoveType( nMoveType or AMB.RegisterEntities.ConfigNPCs.mvt )
    ent:PhysicsInit( nPhysicInit or AMB.RegisterEntities.ConfigNPCs.phi )

    local phys = ent:GetPhysicsObject()
    if IsValid( phys ) then phys:EnableMotion( bEnableMotion or AMB.RegisterEntities.ConfigNPCs.enm ) end

    return phys

end