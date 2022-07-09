-- from: https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/client/surface.lua
Ambi.UI = Ambi.UI or {}
Ambi.UI.Draw = Ambi.UI.Draw or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local surface, draw, math, render = surface, draw, math, render

local ANG2RAD = 0.017453292519939 -- math.pi / 180

local TAB = { {}, {}, {}, {} }
local q1, q2, q3, q4 = TAB[1], TAB[ 2 ], TAB[ 3 ], TAB[4]
local blurboxes = {}
local BLUR = Material( 'pp/blurscreen' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Draw.QuadDash( x1, y1, x2, y2, x3, y3, x4, y4, cColor )
    q1.x, q1.y = x1, y1
    q2.x, q2.y = x2, y2
    q3.x, q3.y = x3, y3
    q4.x, q4.y = x4, y4

    cColor = cColor or C.ABS_WHITE

    surface.SetDrawColor( cColor.r, cColor.g, cColor.b, cColor.a )
    surface.DrawPoly( TAB )
end

function Ambi.UI.Draw.QuadOutlineDash( x1, y1, x2, y2, x3, y3, x4, y4, cColor )
    cColor = cColor or C.ABS_WHITE

    surface.SetDrawColor( cColor.r, cColor.g, cColor.b, cColor.a )
    surface.DrawLine( x1,y1, x2,y2 )
    surface.DrawLine( x2,y2, x3,y3 )
    surface.DrawLine( x3,y3, x4,y4 )
    surface.DrawLine( x4,y4, x1,y1 )
end