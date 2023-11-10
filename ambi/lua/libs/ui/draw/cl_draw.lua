Ambi.UI.Draw = Ambi.UI.Draw or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local surface, draw, math, string, render, cam, timer, table = surface, draw, math, string, render, cam, timer, table
local istable = istable
local DrawSimpleTextOutline = draw.SimpleTextOutlined
local GetFont = Ambi.UI.GetFont

local ROUNDED_ANGLES = {
    [ 0 ] = { true, true, true, true },
    [ 1 ] = { true, true, false, false },
    [ 2 ] = { false, false, true, true },
    [ 3 ] = { false, true, false, true },
    [ 4 ] = { true, false, true, false },
    [ 5 ] = { true, false, false, false },
    [ 6 ] = { false, true, false, false },
    [ 7 ] = { false, false, true, false },
    [ 8 ] = { false, false, false, true },

    [ 'all' ] = { true, true, true, true },
    [ 'top' ] = { true, true, false, false },
    [ 'bottom' ] = { false, false, true, true },
    [ 'right' ] = { false, true, false, true },
    [ 'left' ] = { true, false, true, false },
    [ 'top-left' ] = { true, false, false, false },
    [ 'top-right' ] = { false, true, false, false },
    [ 'bottom-left' ] = { false, false, true, false },
    [ 'bottom-right' ] = { false, false, false, true },

    [ 'top left' ] = { true, false, false, false },
    [ 'top right' ] = { false, true, false, false },
    [ 'bottom left' ] = { false, false, true, false },
    [ 'bottom right' ] = { false, false, false, true },

    [ 'a' ] = { true, true, true, true },
    [ 't' ] = { true, true, false, false },
    [ 'b' ] = { false, false, true, true },
    [ 'r' ] = { false, true, false, true },
    [ 'l' ] = { true, false, true, false },
    [ 'tl' ] = { true, false, false, false },
    [ 'tr' ] = { false, true, false, false },
    [ 'bl' ] = { false, false, true, false },
    [ 'br' ] = { false, false, false, true },
}
local ALIGN_PATTERNS = {
    [ 0 ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP },
    [ 1 ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP },
    [ 2 ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP },
    [ 3 ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM },
    [ 4 ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM },
    [ 5 ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM },
    [ 6 ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER },
    [ 7 ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER },
    [ 8 ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER },

    [ 'top-left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP },
    [ 'top-right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP },
    [ 'top-center' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP },
    [ 'bottom-left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM },
    [ 'bottom-right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM },
    [ 'bottom-center' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM },
    [ 'center-left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER },
    [ 'center-right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER },
    [ 'center' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER },

    [ 'top left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP },
    [ 'top right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP },
    [ 'top center' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP },
    [ 'bottom left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM },
    [ 'bottom right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM },
    [ 'bottom center' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM },
    [ 'center left' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER },
    [ 'center right' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER },

    [ 'tl' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP },
    [ 'tr' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP },
    [ 'tc' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP },
    [ 'bl' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM },
    [ 'br' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM },
    [ 'bc' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM },
    [ 'cl' ] = { TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER },
    [ 'cr' ] = { TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER },
    [ 'c' ] = { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER },
}

local DEFAULT_MAT = Material( 'icon16/accept.png' )
local BLUR = Material( 'pp/blurscreen' )

local cache_fonts = {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function AddCacheFont( sFont, sText, nW, nH )
    cache_fonts[ sFont..' '..sText ] = { nW, nH }
end

local function GetCacheFont( sFont, sText )
    return cache_fonts[ sFont..' '..sText ]
end

function Ambi.UI.Draw.GetCacheFonts()
    return cache_fonts
end

function Ambi.UI.Draw.ClearCacheFonts()
    return table.Empty( cache_fonts )
end

function Ambi.UI.Draw.GetTextSize( sFont, sText )
    local cache = GetCacheFont( sFont, sText )
    if cache then return cache[ 1 ], cache[ 2 ] end

    surface.SetFont( sFont )
    local w, h = surface.GetTextSize( sText )

    AddCacheFont( sFont, sText, w, h )

    return w, h
end

function Ambi.UI.Draw.GetTextSizeX( sFont, sText )
    local x, _ = Ambi.UI.Draw.GetTextSize( sFont, sText )

    return x
end

function Ambi.UI.Draw.GetTextSizeY( sFont, sText )
    local _, y = Ambi.UI.Draw.GetTextSize( sFont, sText )

    return y
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Draw.Box( wSize, hSize, xPos, yPos, cColor, nRounded, anyRoundedAngles )
    wSize, hSize, xPos, yPos = wSize or 0, hSize or 0, xPos or 0, yPos or 0
    cColor = cColor or C.ABS_WHITE
    nRounded = nRounded or 0
    sRoundedAngles = istable( anyRoundedAngles ) and anyRoundedAngles or ROUNDED_ANGLES[ anyRoundedAngles or 0 ] or ROUNDED_ANGLES[ 0 ]

    draw.RoundedBoxEx( nRounded, xPos, yPos, wSize, hSize, cColor, sRoundedAngles[ 1 ], sRoundedAngles[ 2 ], sRoundedAngles[ 3 ], sRoundedAngles[ 4 ] )
end

function Ambi.UI.Draw.Text( xPos, yPos, sText, sFont, cColor, anyAlign, nOutlineWeight, cColorOutline )
    --! this method may be heavy and eating more FPS!
    local font, y, align = GetFont( sFont ) or 'CloseCaption_Normal', yPos or 0, ALIGN_PATTERNS[ anyAlign or 0 ] or ALIGN_PATTERNS[ 0 ]

    local tab = string.Explode( '\n', sText )
    for i = 1, #tab do
        local str = tab[ i ]
        local y_offset = Ambi.UI.Draw.GetTextSizeY( font, str ) or 0
        DrawSimpleTextOutline( str, font, xPos or 0, y + ( y_offset ) * ( i - 1 ), cColor or C.ABS_WHITE, align[ 1 ], align[ 2 ], nOutlineWeight or 1, cColorOutline or C.ABS_BLACK ) 
    end
end

function Ambi.UI.Draw.SimpleText( xPos, yPos, sText, sFont, cColor, anyAlign, nOutlineWeight, cColorOutline )
    local font, align = GetFont( sFont ) or 'CloseCaption_Normal', ALIGN_PATTERNS[ anyAlign or 0 ] or ALIGN_PATTERNS[ 0 ]

    DrawSimpleTextOutline( sText, font, xPos or 0, yPos or 0, cColor or C.ABS_WHITE, align[ 1 ], align[ 2 ], nOutlineWeight or 0, cColorOutline or C.ABS_BLACK ) 
end

function Ambi.UI.Draw.Material( wSize, hSize, xPos, yPos, matImage, cColor )
    cColor = cColor or C.ABS_WHITE

    surface.SetMaterial( matImage or DEFAULT_MAT )
	surface.SetDrawColor( cColor.r, cColor.g, cColor.b, cColor.a )
	surface.DrawTexturedRect( xPos or 0, yPos or 0, wSize or 0, hSize or 0 )
end

function Ambi.UI.Draw.Line( xPosStart, yPosStart, xPosEnd, yPosEnd, cColor )
    cColor = cColor or C.ABS_WHITE

    surface.SetDrawColor( cColor.r, cColor.g, cColor.b, cColor.a )
    surface.DrawLine( xPosStart or 0, yPosStart or 0, xPosEnd or 0, yPosEnd or 0 )
end

function Ambi.UI.Draw.Blur( vguiPanel, nBlur )
    local x, y = vguiPanel:LocalToScreen( 0, 0 )
    local w, h = ScrW(), ScrH()

    surface.SetDrawColor( 255, 255, 255 )
    surface.SetMaterial( BLUR )

    for i = 1, 3 do
        BLUR:SetFloat( '$BLUR', ( i / 3 ) * ( nBlur or 6 ) )
        BLUR:Recompute()

        render.UpdateScreenEffectTexture()

        surface.DrawTexturedRect( x * -1, y * -1, w, h )
    end
end