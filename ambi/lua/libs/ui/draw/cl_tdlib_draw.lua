-- from: https://github.com/Threebow/tdlib/blob/master/tdlib.lua
Ambi.UI.Draw = Ambi.UI.Draw or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local surface, draw, math, table = surface, draw, math, table
local Color, Lerp = Color, Lerp

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Draw.CircleTDLib(x, y, r, cColor )
    cColor = cColor or C.ABS_WHITE

    local circle = {}

    for i = 1, 360 do
        circle[i] = {}
        circle[i].x = x + math.cos(math.rad(i * 360) / 360) * r
        circle[i].y = y + math.sin(math.rad(i * 360) / 360) * r
    end

    surface.SetDrawColor( cColor )
    draw.NoTexture()
    surface.DrawPoly(circle)
end

function Ambi.UI.Draw.ArcTDLib(x, y, ang, p, rad, cColor, seg)
    cColor = cColor or C.ABS_WHITE
    seg = seg || 80
    ang = (-ang) + 180

    local circle = {}

    table.insert(circle, {x = x, y = y})
    for i = 0, seg do
        local a = math.rad((i / seg) * -p + ang)
        table.insert(circle, {x = x + math.sin(a) * rad, y = y + math.cos(a) * rad})
    end

    surface.SetDrawColor(cColor)
    draw.NoTexture()
    surface.DrawPoly(circle)
end

function Ambi.UI.Draw.LerpColorTDLib(frac, from, to)
    return Color(
        Lerp(frac, from.r, to.r),
        Lerp(frac, from.g, to.g),
        Lerp(frac, from.b, to.b),
        Lerp(frac, from.a, to.a)
    )
end