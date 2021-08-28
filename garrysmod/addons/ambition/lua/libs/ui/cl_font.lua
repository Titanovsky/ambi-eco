AMB.UI.Font = AMB.UI.Font or {}
AMB.UI.Font.fonts = AMB.UI.Font.fonts or {}

function AMB.UI.Font.Add( sName, sCategory, tFont )
    surface.CreateFont( sName, tFont )

    if not AMB.UI.Font.fonts[ sCategory ] then AMB.UI.Font.fonts[ sCategory ] = {} end
    AMB.UI.Font.fonts[ sCategory ][ sName ] = true
end

function AMB.UI.Font.AddStandart( sName, sCategory, sFont, nSize, nWeight, bExtended )
    local name = nSize..' '..sName

    local tab = {
        font = sFont,
        size = nSize,
        weight = nWeight,
        extended = bExtended,
        shadow = bShadow
    }

    surface.CreateFont( name, tab )

    if not AMB.UI.Font.fonts[ sCategory ] then AMB.UI.Font.fonts[ sCategory ] = {} end
    AMB.UI.Font.fonts[ sCategory ][ sName ] = true
end

function AMB.UI.Font.GetFonts()
    return AMB.UI.Font.fonts
end