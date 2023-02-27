Ambi.UI.Draw = Ambi.UI.Draw or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local C = Ambi.General.Global.Colors
local surface, math, draw = surface, math, draw 

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Draw.ObliqueRectTech( wSize, hSize, xPos, yPos, cColor, bReverse, matTexture )
    -- from: deleted addon
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
end

local function PrecacheArc( cx, cy, radius, thickness, startang, endang, roughness )
    -- from https://gist.github.com/theawesomecoder61/d2c3a3d42bbce809ca446a85b4dda754
	local triarc = {}
	-- local deg2rad = math.pi / 180
	
	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness
	
	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end
	
		table.insert(triarc, {p1,p2,p3})
	end
	
	-- Return a table of triangles to draw.
	return triarc
end

local function DrawArc( tArc )
    -- from https://gist.github.com/theawesomecoder61/d2c3a3d42bbce809ca446a85b4dda754
	for k,v in ipairs( tArc ) do surface.DrawPoly( v ) end // Draw a premade arc.
end

function Ambi.UI.Draw.Arc( xPos, yPos, cColor, nRadius, nThickness, nRoughness, nStartAngle, nEndAngle, matTexture )
    -- from https://gist.github.com/theawesomecoder61/d2c3a3d42bbce809ca446a85b4dda754
	surface.SetDrawColor( cColor or C.WHITE )
    if matTexture then surface.SetMaterial( matTexture ) else draw.NoTexture() end
	DrawArc( PrecacheArc( xPos or 0, yPos or 0, nRadius or 16, nThickness or 16, nStartAngle or 0, nEndAngle or 360, nRoughness or 2 ) )
end