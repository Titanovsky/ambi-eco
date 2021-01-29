AMB.UI.Draw = AMB.UI.Draw or {}

local w = ScrW()
local h = ScrH()
local surface = surface
local draw = draw
local math = math


-- from https://steamcommunity.com/sharedfiles/filedetails/?id=1120612949
function AMB.UI.Draw.ObliqueRect( xPos, yPos, wSize, hSize, cColor, bReverse, imaterialTexture ) -- thanks by TechoHUD

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

-- from https://github.com/kruzgi/Garrys-Mod-Draw-Circle/blob/master/draw_circle.lua
function AMB.UI.Draw.CustomCircle( xPos1, yPos1, wSize, hSize, cColor, aAngle, xPos2, yPos2, imaterialTexture ) -- thanks by Kruzgi

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