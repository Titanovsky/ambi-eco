Ambi.Entity = Ambi.Entity or {}

local ENTITY = FindMetaTable( 'Entity' )
setmetatable( Ambi.Entity, { __index = ENTITY } )

-- -------------------------------------------------------------------------------------
function ENTITY:Distance( eObj )
	return self:GetPos():Distance( eObj:GetPos() )
end

function ENTITY:CheckDistance( eObj, nDist )
	return ( self:GetPos():Distance( eObj:GetPos() ) <= nDist )
end

-- -------------------------------------------------------------------------------------
function ENTITY:SetDelay( sDelay, nTime, nRepetitions )
	if not sDelay then return end

	nTime = nTime or 1
	nRepetitions = nRepetitions or 1

    local id = self:IsPlayer() and self:SteamID() or self:EntIndex()

	timer.Create( sDelay..'['..id..']', nTime, nRepetitions, function() end )
end

function ENTITY:GetDelay( sDelay )
    local id = self:IsPlayer() and self:SteamID() or self:EntIndex()

	return timer.Exists( sDelay..'['..id..']' ) and math.floor( timer.TimeLeft( sDelay..'['..id..']' ) ) or nil
end

function ENTITY:CheckDelay( sDelay, fFail, fSuccess )
	if self:GetDelay( sDelay ) then
		if fFail then fFail( self ) end

		return true
	else
		if fSuccess then fSuccess( fSuccess ) end

		return false
	end
end