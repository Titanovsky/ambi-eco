Ambi.UI = Ambi.UI or {}
Ambi.UI.type_fonts = Ambi.UI.type_fonts or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local fonts = {} -- DON'T RESAVE THIS FILE, WHEN YOUR SERVER WORKING! I made this decision for faster check in every frame (see Ambi.UI.Draw.Text)
local MAX_FONTS = 2300 -- the last amount of fonts, which don't crashed game. More fonts can will crash gmod.
local DEFAULT_FONTS = {
    [ 'BudgetLabel' ] = 'BudgetLabel',
    [ 'CenterPrintText' ] = 'CenterPrintText',
    [ 'ChatFont' ] = 'ChatFont',
    [ 'ClientTitleFont' ] = 'ClientTitleFont',
    [ 'CloseCaption_Bold' ] = 'CloseCaption_Bold',
    [ 'CloseCaption_BoldItalic' ] = 'CloseCaption_BoldItalic',
    [ 'CloseCaption_Italic' ] = 'CloseCaption_Italic',
    [ 'CloseCaption_Normal' ] = 'CloseCaption_Normal',
    [ 'CreditsLogo' ] = 'CreditsLogo',
    [ 'CreditsOutroLogos' ] = 'CreditsOutroLogos',
    [ 'CreditsOutroText' ] = 'CreditsOutroText',
    [ 'CreditsText' ] = 'CreditsText',
    [ 'Crosshairs' ] = 'Crosshairs',
    [ 'DebugFixed' ] = 'DebugFixed',
    [ 'DebugFixedSmall' ] = 'DebugFixedSmall',
    [ 'DebugOverlay' ] = 'DebugOverlay',
    [ 'Default' ] = 'Default',
    [ 'DefaultFixed' ] = 'DefaultFixed',
    [ 'DefaultFixedDropShadow' ] = 'DefaultFixedDropShadow',
    [ 'DefaultSmall' ] = 'DefaultSmall',
    [ 'DefaultUnderline' ] = 'DefaultUnderline',
    [ 'DefaultVerySmall' ] = 'DefaultVerySmall',
    [ 'HDRDemoText' ] = 'HDRDemoText',
    [ 'HL2MPTypeDeath' ] = 'HL2MPTypeDeath',
    [ 'HudDefault' ] = 'HudDefault',
    [ 'HudHintTextLarge' ] = 'HudHintTextLarge',
    [ 'HudHintTextSmall' ] = 'HudHintTextSmall',
    [ 'HudNumbers' ] = 'HudNumbers',
    [ 'HudNumbersGlow' ] = 'HudNumbersGlow',
    [ 'HudNumbersSmall' ] = 'HudNumbersSmall',
    [ 'HudSelectionNumbers' ] = 'HudSelectionNumbers',
    [ 'HudSelectionText' ] = 'HudSelectionText',
    [ 'Marlett' ] = 'Marlett',
    [ 'QuickInfo' ] = 'QuickInfo',
    [ 'TargetID' ] = 'TargetID',
    [ 'TargetIDSmall' ] = 'TargetIDSmall',
    [ 'Trebuchet18' ] = 'Trebuchet18',
    [ 'Trebuchet24' ] = 'Trebuchet24',
    [ 'WeaponIcons' ] = 'WeaponIcons',
    [ 'WeaponIconsSelected' ] = 'WeaponIconsSelected',
    [ 'WeaponIconsSmall' ] = 'WeaponIconsSmall',
    [ 'DermaDefault' ] = 'DermaDefault',
    [ 'DermaDefaultBold' ] = 'DermaDefaultBold',
    [ 'DermaLarge' ] = 'DermaLarge',
    [ 'GModNotify' ] = 'GModNotify',
    [ 'ScoreboardDefault' ] = 'ScoreboardDefault',
    [ 'ScoreboardDefaultTitle' ] = 'ScoreboardDefaultTitle',
}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local surface_CreateFont = surface.CreateFont
function surface.CreateFont( sName, tFont )
    sName, tFont = sName or 'NoName', tFont or { font = 'Arial', size = 10 }

    local i = 0
    for k, v in pairs( fonts ) do
        i = i + 1
    end
    
    if not fonts[ sName ] then
        if ( i >= MAX_FONTS ) then MsgC( C.AMBI_BLUE, '[Ambi.UI] ', C.AMBI_WHITE, 'Cannot to create more fonts than '..MAX_FONTS..', because gmod.exe can will crashed\n' ) return end

        local amount = i + 1
        MsgC( C.AMBI_BLUE, '[Ambi.UI] ', C.AMBI_WHITE, 'Created font: ', C.AMBI_GRAY, sName..' ['..amount..']\n' )

        fonts[ sName ] = sName
    end

    return surface_CreateFont( sName, tFont )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.AddFont( sName, tFont )
    if not tFont then return end

    sName = sName or ''

    if not tFont.category then tFont.category = 'Other' end

    surface.CreateFont( sName, tFont )
end

function Ambi.UI.SimpleAddFont( sName, sFont, sCategory, nSize, nWeight, bExtended, bShadow, bAntialias, bRotary, bItalic, bUnderline, bStrikeout, nBlurSize, nScanlines, bAdditive, bOutline, bSymbol )
    sName = sName or ''
    
    local name = nSize..' '..sName

    local tab = {
        font = sFont, -- Arial
        category = sCategory or 'Other',
        size = nSize, -- 13
        weight = nWeight, -- 500
        extended = bExtended, -- false
        shadow = bShadow, -- false
        blursize = nBlurSize, -- 0
        scanlines = nScanlines, -- 0
        antialias = bAntialias, -- true
        italic = bItalic, -- false
        underline = bUnderline, -- false
        strikeout = bStrikeout, -- false
        rotary = bRotary, -- false 
        shadow = bShadow, -- false
        symbol = bSymbol, -- false 
        additive = bAdditive, -- false
        outline = bOutline -- false
    }

    surface.CreateFont( name, tab )
end

function Ambi.UI.AddFontFromType( sName, sType, sCategory, nSize, nWeight, tFont )
    local type = Ambi.UI.type_fonts[ sType ]
    if not type then return end 

    local tab_font = {
        font = type.font,
        extended = type.extended,
        category = sCategory or 'Other',
        size = nSize or type.size,
        weight = nWeight or type.weight,
    }

    if tFont then
        for k, v in pairs( tFont ) do
            tab_font[ k ] = v
        end
    end

    Ambi.UI.AddFont( sName, tab_font )
end

function Ambi.UI.AddFontType( sType, sFont, sCategory, bExtended, nWeight )
    Ambi.UI.type_fonts[ sType ] = {
        font = sFont,
        extended = bExtended,
        category = sCategory or 'Other',
        weight = nWeight
    }
end

function Ambi.UI.SafeFont( sName )
    if Ambi.UI.GetFont( sName ) then return sName end
    
    local type_from_name = string.Explode( ' ', sName )
    local size = tonumber( type_from_name[ 1 ] )
    table.remove( type_from_name, 1 ) -- remove size in name

    local name_from_type = table.concat( type_from_name, ' ' )
    --print( name_from_type )

    local type = Ambi.UI.type_fonts[ name_from_type ]
    if not type then return 'Default' end 

    Ambi.UI.SimpleAddFont( name_from_type, type.font, 'Created By Ambi.UI.SafeFont()', size, type.weight, ( type.extended == nil ) and true or type.extended )

    return sName
end

function Ambi.UI.GetFont( sName )
    return fonts[ sName ] or DEFAULT_FONTS[ sName ]
end

function Ambi.UI.GetFonts()
    return fonts
end

function Ambi.UI.Fonts()
    return Ambi.UI.GetFonts()
end

function Ambi.UI.GetFontType( sType )
    return Ambi.UI.type_fonts[ sType ]
end

function Ambi.UI.GetFontTypes()
    return Ambi.UI.type_fonts
end