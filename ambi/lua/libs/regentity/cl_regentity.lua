Ambi.RegEntity = Ambi.RegEntity or {}

function Ambi.RegEntity.Draw( eObj, bShadow, nFlag )
    bShadow = bShadow or true
    nFlag = nFlag or STUDIO_RENDER

    eObj:DrawModel( nFlag )
    eObj:DrawShadow( bShadow )

    return eObj
end