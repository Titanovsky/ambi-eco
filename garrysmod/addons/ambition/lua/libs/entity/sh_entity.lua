AMB.Entity = AMB.Entity or {}

local ENTITY = FindMetaTable( 'Entity' )
setmetatable( AMB.Entity, { __index = ENTITY } )