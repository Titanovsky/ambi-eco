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
function ENTITY:SetDelayTime( sDelay, nTime, nRepetitions, fAction )
	if not sDelay then return end

	nTime = nTime or 1
	nRepetitions = nRepetitions or 1

    local id = tostring( self )

	timer.Create( sDelay..'['..id..']', nTime, nRepetitions, fAction or function() end )
end

function ENTITY:GetDelayTime( sDelay )
    local id = tostring( self )

	return timer.Exists( sDelay..'['..id..']' ) and math.floor( timer.TimeLeft( sDelay..'['..id..']' ) ) or nil
end

function ENTITY:CheckDelayTime( sDelay, fFail, fSuccess )
	if self:GetDelayTime( sDelay ) then
		if fFail then fFail( self ) end

		return true
	else
		if fSuccess then fSuccess( fSuccess ) end

		return false
	end
end