AMB.UI = AMB.UI or {}
AMB.UI.Draw = AMB.UI.Draw or {}

-- -------------------------------------------------------------------------------------
local C = AMB.Ambition.Global.Colors
local W, H = ScrW(), ScrH()
local surface, draw, math, string, Material, FrameTime, Matrix, SysTime, ipairs = surface, draw, math, string, Material, FrameTime, Matrix, SysTime, ipairs
local Explode = string.Explode
local SimpTextOutl, SimpText, DrawPoly, DrawLine, SetFont, GetTextSize, SetMaterial, SetDrawColor, DrawTexturedRect, DrawRect, DrawText, SetTextPos, RoundedBoxEx, SetTextColor = draw.SimpleTextOutlined, draw.SimpleText, surface.DrawPoly, surface.DrawLine, surface.SetFont, surface.GetTextSize, surface.SetMaterial, surface.SetDrawColor, surface.DrawTexturedRect, surface.DrawRect, draw.RoundedBoxEx, surface.DrawText, surface.SetTextPos, surface.SetTextColor
local Min, Max, Cos, Sin, Rad, PI = math.min, math.max, math.cos, math.sin, math.rad, math.pi
local SetMetaTable = setmetatable
local TimerCreate = timer.Create
local PushModelMatrix, PopModelMatrix = cam.PushModelMatrix, cam.PopModelMatrix
local SetScissorRect, UpdateScreenEffectTexture = render.SetScissorRect, render.UpdateScreenEffectTexture
-- -------------------------------------------------------------------------------------
-- взял с SuperiorServers/dash
local cache_sizes = SetMetaTable( {}, { __mode = 'k' } )
TimerCreate( 'AmbUIDrawClearFontCache', 1800, 0, function()
    for i = 1, #cache_sizes do
        cache_sizes[ i ] = nil
    end
end)

function AMB.UI.Draw.GetTextSize( sFont, sText )
    if ( cache_sizes[ sFont ] == nil ) then cache_sizes[ sFont ] = {} end

    if ( cache_sizes[ sFont ][ sText ] == nil ) then
        local w, h = GetTextSize( sText )
        cache_sizes[ sFont ][ sText ] = {
            w = w,
            h = h
        }

        return w, h
    end

    return cache_sizes[ sFont ][ sText ].w, cache_sizes[ sFont ][ sText ].h
end
local GetTextSizeAmbition = AMB.UI.Draw.GetTextSize

function AMB.UI.Draw.GetTextSizeX( sFont, sText )
    local x, _ = GetTextSizeAmbition( sFont, sText )

    return x
end

function AMB.UI.Draw.GetTextSizeY( sFont, sText )
    local _, y = GetTextSizeAmbition( sFont, sText )

    return y
end

-- -------------------------------------------------------------------------------------

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
function AMB.UI.Draw.Box( wSize, hSize, xPos, yPos, cColor, nRounded, anyRoundedAngles )
    wSize, hSize, xPos, yPos = wSize or 0, hSize or 0, xPos or 0, yPos or 0
    cColor = cColor or C.ABS_WHITE
    nRounded = nRounded or 0
    sRoundedAngles = ROUNDED_ANGLES[ anyRoundedAngles or 0 ] or ROUNDED_ANGLES[ 0 ]

    RoundedBoxEx( nRounded, xPos, yPos, wSize, hSize, cColor, sRoundedAngles[ 1 ], sRoundedAngles[ 2 ], sRoundedAngles[ 3 ], sRoundedAngles[ 4 ] )
end

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
function AMB.UI.Draw.Text( xPos, yPos, sText, sFont, cColor, anyAlign, nOutlineWeight, cColorOutline )
    -- @ the method may be heavy and eating more FPS!
    local Draw = ( ( nOutlineWeight or 0 ) > 0 ) and SimpTextOutl or SimpText
    local font, y, align = sFont or 'Default', yPos or 0, ALIGN_PATTERNS[ anyAlign or 0 ] or ALIGN_PATTERNS[ 0 ]

    local tab = Explode( '\n', sText or '' )
    for i = 1, #tab do
        local str = tab[ i ]
        local y_offset = UT.GetTextSizeY( str, font )
        Draw( str, font, xPos or 0, y + ( y_offset - 8 ) * ( i - 1 ), cColor or C.ABS_WHITE, align[ 1 ], align[ 2 ], nOutlineWeight or 1, cColorOutline or C.ABS_BLACK ) 
    end
end

local DEFAULT_MAT = Material( '' )
function AMB.UI.Draw.Material( wSize, hSize, xPos, yPos, matImage, nColorRed, nColorGreen, nColorBlue, nColorAlpha )
    SetMaterial( matImage or DEFAULT_MAT )
	SetDrawColor( nColorRed or 255, nColorGreen or 255, nColorBlue or 255, nColorAlpha or 255 )
	DrawTexturedRect( xPos or 0, yPos or 0, wSize or 0, hSize or 0 )
end

function AMB.UI.Draw.Line( xPosStart, yPosStart, xPosEnd, yPosEnd, nColorRed, nColorGreen, nColorBlue, nColorAlpha )
    SetDrawColor( nColorRed or 255, nColorGreen or 255, nColorBlue or 255, nColorAlpha or 255 )
    DrawLine( xPosStart or 0, yPosStart or 0, xPosEnd or 0, yPosEnd or 0 )
end

local BLUR = Material( 'pp/blurscreen' )
function AMB.UI.Draw.Blur( vguiPanel, nBlur )
    local x, y = vguiPanel:LocalToScreen( 0, 0 )
    local w, h = ScrW(), ScrH()

    SetDrawColor( 255, 255, 255 )
    SetMaterial( BLUR )

    for i = 1, 3 do
        BLUR:SetFloat( '$BLUR', ( i / 3 ) * ( nBlur or 6 ) )
        BLUR:Recompute()

        UpdateScreenEffectTexture()

        DrawTexturedRect( x * -1, y * -1, w, h )
    end
end

-- -------------------------------------------------------------------------------------

-- by TechoHUD
function AMB.UI.Draw.ObliqueRect( xPos, yPos, wSize, hSize, cColor, bReverse, imaterialTexture )
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=1120612949
	local rect = {}

	if bReverse then
        rect[1] = { x = xPos, y = yPos }
        rect[2] = { x = xPos + wSize, y = yPos }
        rect[3] = { x = ( xPos + wSize ) - hSize * 0.8, y = yPos + hSize }
        rect[4] = { x = xPos - hSize * 0.8, y = yPos + hSize }
    else
        rect[1] = { x = xPos, y = yPos }
        rect[2] = { x = ( xPos + wSize ), y = yPos }
        rect[3] = { x = xPos + wSize + hSize * 0.8, y = yPos + hSize }
        rect[4] = { x = xPos + hSize, y = yPos + hSize }
    end

    surface.SetDrawColor( cColor:Unpack() )
    if imaterialTexture then surface.SetMaterial( imaterialTexture ) else draw.NoTexture() end
    surface.DrawPoly( rect )
end

-- by Kruzgi
function AMB.UI.Draw.CircleKruzgi( xPos1, yPos1, wSize, hSize, cColor, aAngle, xPos2, yPos2, imaterialTexture )
    -- https://github.com/kruzgi/Garrys-Mod-Draw-Circle/blob/master/draw_circle.lua
    for i = 0, aAngle do
        local c = math.cos( math.rad( i ) )
        local s = math.sin( math.rad( i ) )
        local newx = yPos2 * s - xPos2 * c
        local newy = yPos2 * c + xPos2 * s

        surface.SetDrawColor( cColor )
        if imaterialTexture then surface.SetMaterial( imaterialTexture ) else draw.NoTexture() end
        surface.DrawTexturedRectRotated( xPos1 + newx, yPos1 + newy, wSize, hSize, i )
    end
end

-- -------------------------------------------------------------------------------------
-- by SuperiorServers
-- Source: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/client/surface.lua

local TAB = { {}, {}, {}, {} }
local q1, q2, q3, q4 = TAB[1], TAB[ 2 ], TAB[ 3 ], TAB[4]
function AMB.UI.Draw.Quad( x1, y1, x2, y2, x3, y3, x4, y4 )
    q1.x, q1.y = x1, y1
    q2.x, q2.y = x2, y2
    q3.x, q3.y = x3, y3
    q4.x, q4.y = x4, y4

    DrawPoly( TAB )
end

local TABUV = { {}, {}, {}, {} }
local quv1, quv2, quv3, quv4 = TABUV[ 1 ], TABUV[ 2 ], TABUV[ 3 ], TABUV[ 4 ]
function AMB.UI.Draw.QuadUV( x1, y1, x2, y2, x3, y3, x4, y4 )
    local xmin, ymin = Max
    local xmax, ymax = Min

    xmin = x1
    if ( x2 < xmin ) then xmin = x2 end
    if ( x3 < xmin ) then xmin = x3 end
    if ( x4 < xmin ) then xmin = x4 end

    ymin = y1
    if ( y2 < ymin ) then ymin = y2 end
    if ( y3 < ymin ) then ymin = y3 end
    if ( y4 < ymin ) then ymin = y4 end

    xmax = x1
    if ( x2 > xmax ) then xmax = x2 end
    if ( x3 > xmax ) then xmax = x3 end
    if ( x4 > xmax ) then xmax = x4 end

    ymax = y1
    if ( y2 > ymax ) then ymax = y2 end
    if ( y3 > ymax ) then ymax = y3 end
    if ( y4 > ymax ) then ymax = y4 end

    local dy = ymax - ymin
    local dx = xmax - xmin

    quv1.u, quv1.v = ( x1 - xmin ) / dx, ( y1 - ymin ) / dy
    quv2.u, quv2.v = ( x2 - xmin ) / dx, ( y2 - ymin ) / dy
    quv3.u, quv3.v = ( x3 - xmin ) / dx, ( y3 - ymin ) / dy
    quv4.u, quv4.v = ( x4 - xmin ) / dx, ( y4 - ymin ) / dy

    quv1.x, quv1.y = x1, y1
    quv2.x, quv2.y = x2, y2
    quv3.x, quv3.y = x3, y3
    quv4.x, quv4.y = x4, y4

    DrawPoly( TABUV )
end

function AMB.UI.Draw.QuadOutline( x1, y1, x2, y2, x3, y3, x4, y4 )
    DrawLine( x1,y1, x2,y2 )
    DrawLine( x2,y2, x3,y3 )
    DrawLine( x3,y3, x4,y4 )
    DrawLine( x4,y4, x1,y1 )
end

local ANG2RAD = 0.017453292519939 -- 3.141592653589 / 180
local DrawQuad = AMB.UI.Draw.Quad
function AMB.UI.Draw.Arc( _x, _y, r1, r2, aStart, aFinish, steps )
    aStart, aFinish = aStart * ANG2RAD, aFinish * ANG2RAD
    local step = ( ( aFinish - aStart ) / steps )
    local c = steps

    local a, c1, s1, c2, s2

    c2, s2 = Cos( aStart ), Sin( aStart )
    for i = 0, steps - 1 do
        a = i * step + aStart
        c1, s1 = c2, s2
        c2, s2 = Cos( a + step ), Sin( a + step )

        DrawQuad( 
            _x+c1*r1, _y+s1*r1,
            _x+c1*r2, _y+s1*r2,
            _x+c2*r2, _y+s2*r2,
            _x+c2*r1, _y+s2*r1 
        )

        c = c - 1
        if c < 0 then break end
    end
end

function AMB.UI.Draw.ArcOutline(_x, _y, r1, r2, aStart, aFinish, steps)
    aStart, aFinish = aStart * ANG2RAD, aFinish * ANG2RAD
    local step = ( ( aFinish - aStart ) / steps )
    local c = steps

    local a, c1, s1, c2, s2

    c2, s2 = Cos( aStart ), Sin( aStart )
    DrawLine( _x+c2*r1, _y+s2*r1, _x+c2*r2, _y+s2*r2 )

    for i = 0, steps - 1 do
        a = i * step + aStart
        c1, s1 = c2, s2
        c2, s2 = Cos(a+step), Sin(a+step)

        DrawLine( 
            _x+c1*r2, _y+s1*r2,
            _x+c2*r2, _y+s2*r2 
        )

        DrawLine( 
            _x+c1*r1, _y+s1*r1,
            _x+c2*r1, _y+s2*r1 
        )

        c = c - 1
        if c < 0 then break end
    end

    DrawLine( _x+c2*r1, _y+s2*r1, _x+c2*r2, _y+s2*r2 )
end

local function DrawRectDash(x, y, w, h, t)
	if not t then t = 1 end

	DrawRect(x, y, w, t)
	DrawRect(x, y + (h - t), w, t)
	DrawRect(x, y, t, h)
	DrawRect(x + (w - t), y, t, h)
end

function AMB.UI.Draw.BoxDash(x, y, w, h, col)
	SetDrawColor(col)
	DrawRect(x, y, w, h)
end

function AMB.UI.Draw.BoxDashOutline(x, y, w, h, col, bordercol, thickness)
	SetDrawColor(col)
	DrawRect(x + 1, y + 1, w - 2, h - 2)

	SetDrawColor(bordercol)
	DrawRectDash(x, y, w, h, thickness)
end

function AMB.UI.Draw.BoxDashBorder( x, y, w, h, cColor, thickness )
	SetDrawColor( cColor )
	DrawRectDash(x, y, w, h, thickness)
end

local blurboxes = {}
function AMB.UI.Draw.BlurResample( nAmount )
	SetDrawColor( 255, 255, 255 )
	SetMaterial( BLUR )

	for i = 1, 3 do
		blur:SetFloat( '$blur', ( i / 3 ) * ( nAmount or 8 ) )
		blur:Recompute()
		UpdateScreenEffectTexture()

		for k, v in ipairs( blurboxes ) do
			SetScissorRect( v.x, v.y, v.x + v.w, v.y + v.h, true )
			DrawTexturedRect( 0, 0, ScrW(), ScrH() )
			SetScissorRect( 0, 0, 0, 0, false )
            
			blurboxes[ k ] = nil
		end

	end
end

function AMB.UI.Draw.BlurBox( x, y, w, h )
	blurboxes[ #blurboxes + 1 ] = {
		x = x,
		y = y,
		w = w,
		h = h
	}
end

function AMB.UI.Draw.BlurDash( vguiPanel )
	AMB.UI.Draw.BlurBox( vguiPanel:GetBounds() )
end

function AMB.UI.Draw.TextRotatedDash( sText, nX, nY, cColor, sFont, nAng )
	SetFont( sFont )
	SetTextColor( cColor )

	local m = Matrix()
	m:SetAngles( Angle( 0,  nAng , 0 ) )
	m:SetTranslation( Vector( nX , nY , 0) )
	PushModelMatrix(m)
		surface.SetTextPos( 0, 0 )
		surface.DrawText( sText )
	PopModelMatrix()
end