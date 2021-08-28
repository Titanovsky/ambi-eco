AMB.RegEntity = AMB.RegEntity or {}

local C, A = AMB.Ambition.Global.Colors, AMB.Ambition

function AMB.RegEntity.Initialize( eObj, sModel, sMat, cColor, nUseType, nRenderMode, bDropToFloor )
    sMat = sMat or ''
    cColor = cColor or C.ABS_WHITE
    nUseType = nUseType or SIMPLE_USE
    nRenderMode = nRenderMode or RENDERMODE_NORMAL

    if sModel then eObj:SetModel( sModel ) end
    eObj:SetMaterial( sMat )
    eObj:SetColor( cColor )
    eObj:SetUseType( nUseType )
    eObj:SetRenderMode( nRenderMode )
    if bDropToFloor then eObj:DropToFloor() end

    return eObj
end

function AMB.RegEntity.Physics( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
    -- for NPC: AMB.Entities.Physics( self, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false )
    
    nMoveType = nMoveType or MOVETYPE_VPHYSICS
    nPhysicInit = nPhysicInit or SOLID_VPHYSICS
    nCollisionGroup = nCollisionGroup or COLLISION_GROUP_NONE

    eObj:SetMoveType( nMoveType )
    eObj:PhysicsInit( nPhysicInit )
    eObj:SetCollisionGroup( nCollisionGroup )

    local phys = eObj:GetPhysicsObject()
    if IsValid( phys ) then 
        phys:EnableMotion( bEnableMotion ) 
        if bWake then phys:Wake() end
        if bSleep then phys:Sleep() end
    end

    return phys
end

function AMB.RegEntity.Capability( eObj, nCap )
    if not nCap then A.Error( 'Entities', 'Capability not found' ) return end

    eObj:CapabilitiesAdd( nCap )

    return eObj
end

function AMB.RegEntity.Hull( eObj, nHullType )
    nHullType = nHullType or HULL_HUMAN

    eObj:SetHullType( nHullType)
	eObj:SetHullSizeNormal()

    return eObj
end