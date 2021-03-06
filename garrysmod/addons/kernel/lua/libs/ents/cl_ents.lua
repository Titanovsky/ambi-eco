AMB.Entities = AMB.Entities or {}

function AMB.Entities.Draw( eObj, bShadow, nFlag )

    bShadow = bShadow or true
    nFlag = nFlag or STUDIO_RENDER

    eObj:DrawModel( nFlag )
    eObj:DrawShadow( bShadow )

    return eObj

end