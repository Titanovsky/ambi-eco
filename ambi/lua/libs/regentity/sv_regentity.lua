Ambi.RegEntity = Ambi.RegEntity or {}

local C, Gen = Ambi.General.Global.Colors, Ambi.General

function Ambi.RegEntity.Initialize( eObj, sModel, sMat, cColor, nUseType, nRenderMode, bDropToFloor )
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

function Ambi.RegEntity.Physics( eObj, nMoveType, nPhysicInit, nCollisionGroup, bEnableMotion, bWake, bSleep )
    -- for NPC: Ambi.RegEntity.Physics( self, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false )
    
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

function Ambi.RegEntity.Capability( eObj, nCap )
    if not nCap then Gen.Error( 'Entities', 'Capability not found' ) return end

    eObj:CapabilitiesAdd( nCap )

    return eObj
end

function Ambi.RegEntity.Hull( eObj, nHullType )
    nHullType = nHullType or HULL_HUMAN

    eObj:SetHullType( nHullType )
	eObj:SetHullSizeNormal()

    return eObj
end