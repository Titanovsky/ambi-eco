AMB.RegisterEntities = AMB.RegisterEntities or {}

function AMB.RegisterEntities.DrawEntity( ent, bShadow, nFlag )

    ent:DrawModel( nFlag )
    ent:DrawShadow( bShadow )

    return ent

end