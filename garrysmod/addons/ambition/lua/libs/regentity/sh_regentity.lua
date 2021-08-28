AMB.RegEntity = AMB.RegEntity or {}

local A = AMB.Ambition

AMB.RegEntity.ents = AMB.RegEntity.ents or {}
AMB.RegEntity.weps = AMB.RegEntity.weps or {}

function AMB.RegEntity.Register( sClass, sType, tEntity )
    if not sClass then A.Error( 'RegEntity', 'Cannot register entity without class' ) return end
    if not sType then A.Error( 'RegEntity', 'Cannot register entity without types: ents or weapons' ) return end
    if not istable( tEntity ) then A.Error( 'RegEntity', 'The third argument is not a table with data of entity' ) return end

    if ( sType == 'ents' ) then AMB.RegEntity.ents[ sClass ] = tEntity return scripted_ents.Register( tEntity, string.lower( sClass ) ) end
    if ( sType == 'weapons' ) then AMB.RegEntity.weps[ sClass ] = tEntity return weapons.Register( tEntity, string.lower( sClass ) ) end

    A.Error( 'RegEntity', 'Registration entity is failed, because unknow type '..sType )

    return false
end

function AMB.RegEntity.GetEntities()
    return AMB.RegEntity.ents
end

function AMB.RegEntity.GetWeapons()
    return AMB.RegEntity.weps
end