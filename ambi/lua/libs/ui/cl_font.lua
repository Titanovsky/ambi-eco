Ambi.UI.Font = Ambi.UI.Font or {}
Ambi.UI.Font.fonts = Ambi.UI.Font.fonts or {}

function Ambi.UI.Font.Add( sName, sCategory, tFont )
    if not tFont then return end

    sName = sName or ''
    sCategory = sCategory or ''

    surface.CreateFont( sName, tFont )

    if not Ambi.UI.Font.fonts[ sCategory ] then Ambi.UI.Font.fonts[ sCategory ] = {} end
    Ambi.UI.Font.fonts[ sCategory ][ sName ] = true
end

function Ambi.UI.Font.AddStandart( sName, sCategory, sFont, nSize, nWeight, bExtended )
    sName = sName or ''
    sCategory = sCategory or ''
    
    local name = nSize..' '..sName

    local tab = {
        font = sFont,
        size = nSize,
        weight = nWeight,
        extended = bExtended,
        shadow = bShadow
    }

    surface.CreateFont( name, tab )

    if not Ambi.UI.Font.fonts[ sCategory ] then Ambi.UI.Font.fonts[ sCategory ] = {} end
    Ambi.UI.Font.fonts[ sCategory ][ sName ] = true
end

function Ambi.UI.Font.GetFonts()
    return Ambi.UI.Font.fonts
end