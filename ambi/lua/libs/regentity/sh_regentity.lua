Ambi.RegEntity = Ambi.RegEntity or {}

local Gen = Ambi.General

Ambi.RegEntity.ents = Ambi.RegEntity.ents or {}
Ambi.RegEntity.weps = Ambi.RegEntity.weps or {}

function Ambi.RegEntity.Register( sClass, sType, tEntity )
    if not sClass then Gen.Error( 'RegEntity', 'Cannot register entity without class' ) return end
    if not sType then Gen.Error( 'RegEntity', 'Cannot register entity without types: ents or weapons' ) return end
    if not istable( tEntity ) then Gen.Error( 'RegEntity', 'The third argument is not a table with data of entity' ) return end

    if ( sType == 'ents' ) then Ambi.RegEntity.ents[ sClass ] = tEntity return scripted_ents.Register( tEntity, string.lower( sClass ) ) end
    if ( sType == 'weapons' ) then Ambi.RegEntity.weps[ sClass ] = tEntity return weapons.Register( tEntity, string.lower( sClass ) ) end

    Gen.Error( 'RegEntity', 'Registration entity is failed, because unknow type '..sType )

    return false
end

function Ambi.RegEntity.GetEntities()
    return Ambi.RegEntity.ents
end

function Ambi.RegEntity.GetWeapons()
    return Ambi.RegEntity.weps
end