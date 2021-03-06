AMB.Entities = AMB.Entities or {}
AMB.Entities.table_ents = AMB.Entities.table_ents or {}
AMB.Entities.table_weps = AMB.Entities.table_weps or {}

function AMB.Entities.Register( sClass, sType, tEntity )

    if not sClass then AMB.ErrorLog( 'Entities', 'Cannot register entity without class' ) return end
    if not sType then AMB.ErrorLog( 'Entities', 'Cannot register entity without types: ents or weapons' ) return end
    if not istable( tEntity ) then AMB.ErrorLog( 'Entities', 'The third argument is not a table with data of entity' ) return end

    if ( sType == 'ents' ) then AMB.Entities.table_ents[ sClass ] = tEntity return scripted_ents.Register( tEntity, string.lower( sClass ) ) end
    if ( sType == 'weapons' ) then AMB.Entities.table_weps[ sClass ] = tEntity return weapons.Register( tEntity, string.lower( sClass ) ) end

    AMB.ErrorLog( 'Entities', 'Registration entity is failed, because unknow type '..sType )

    return false

end

function AMB.Entities.GetEntities()

    return AMB.Entities.table_ents

end

function AMB.Entities.GetWeapons()

    return AMB.Entities.table_weps

end