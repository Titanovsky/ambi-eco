AMB.UI = AMB.UI or {}
AMB.UI.Fonts = AMB.UI.Fonts or {}
AMB.UI.Fonts.table = AMB.UI.Fonts.table or {}

function AMB.UI.Fonts.CreateFont( sName, sFont, nSize, nWeight, bItalic )

    surface.CreateFont( sName, {

	    font = sFont, 
	    size = nSize or 8,
        weight = nWeight or 500,
        italic = bItalic or false,
        outline = bOutline or false

    } )

    AMB.UI.Fonts.table[ sName ] = {

        font = sFont, 
	    size = nSize or 8,
        weight = nWeight or 500,
        italic = bItalic or false,
        outline = bOutline or false

    }

end

function AMB.UI.Fonts.GetTable()

    return AMB.UI.Fonts.table

end

function AMB.UI.Fonts.PrintTable()

    PrintTable( AMB.UI.Fonts.table )

end