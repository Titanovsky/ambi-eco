AMB.RegisterEntities = AMB.RegisterEntities or {}
AMB.RegisterEntities.ConfigNPCs = AMB.RegisterEntities.ConfigNPCs or {}

AMB.RegisterEntities.ConfigNPCs.mdl = 'models/gman_high.mdl'
AMB.RegisterEntities.ConfigNPCs.mat = ''
AMB.RegisterEntities.ConfigNPCs.col = Color( 255, 255, 255 )
AMB.RegisterEntities.ConfigNPCs.rnm = RENDERMODE_NORMAL
AMB.RegisterEntities.ConfigNPCs.ust = SIMPLE_USE

function AMB.RegisterEntities.InitNPC( ent, sModel, sMat, cColor, nUseType, bDropToFloor, nRenderMode )

    ent:SetModel( sModel or AMB.RegisterEntities.ConfigNPCs.mdl )
    ent:SetMaterial( sMat or AMB.RegisterEntities.ConfigNPCs.mat )
    ent:SetColor( cColor or AMB.RegisterEntities.ConfigNPCs.col )
    ent:SetRenderMode( nRenderMode or AMB.RegisterEntities.ConfigNPCs.rnm )
    ent:SetUseType( nUseType or AMB.RegisterEntities.ConfigNPCs.ust )
    if bDropToFloor then ent:DropToFloor() end
    
    return ent

end

function AMB.RegisterEntities.BehaviorNPC( eNPC, nHullType )

    eNPC:SetHullType( nHullType or HULL_HUMAN )
	eNPC:SetHullSizeNormal()

    return eNPC

end

function AMB.RegisterEntities.CapabilityNPC( eNPC, nCap )

    eNPC:CapabilitiesAdd( nCap )

    return eNPC

end

function AMB.RegisterEntities.PhysicsNPC( eNPC, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion )

    eNPC:SetMoveType( nMoveType or MOVETYPE_NONE )
    eNPC:SetSolid( nSolid or SOLID_BBOX )
    eNPC:SetCollisionGroup( nCollisionGroup or COLLISION_GROUP_PLAYER )

    local phys = eNPC:GetPhysicsObject()
    if IsValid( phys ) then 
    
        phys:EnableMotion( bEnableMotion or false ) 
        
        return phys

    end

end