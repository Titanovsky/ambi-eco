Ambi.UI.Draw = Ambi.UI.Draw or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local surface, math, draw = surface, math, draw 

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Draw.ObliqueRectTech( wSize, hSize, xPos, yPos, cColor, bReverse, matTexture )
    cColor = cColor or C.ABS_WHITE

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

    surface.SetDrawColor( cColor.r, cColor.g, cColor.b, cColor.a )
    if matTexture then surface.SetMaterial( matTexture ) else draw.NoTexture() end
    surface.DrawPoly( rect )
end1