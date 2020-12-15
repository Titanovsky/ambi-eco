local ENT = {}

ENT.Class       = 'amb_gm_chair'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Chair'
ENT.Author		= AMB.G.AUTHOR
ENT.Category	= AMB.G.Category( 'Ambition' )
ENT.Spawnable   = true

scripted_ents.Register( ENT, ENT.Class )

if CLIENT then

    ENT.RenderGroup = AMB.G.RENDER

    function ENT:DrawTranslucent()

        AMB.RegisterEntities.DrawEntity( self, false )

    end

    scripted_ents.Register( ENT, ENT.Class )

    return 0

end 

function ENT:Initialize()

    AMB.RegisterEntities.InitEntity( self, 'models/props_c17/chair02a.mdl', 'models/debug/debugwhite', AMB.G.C.ABS_RED )
    AMB.RegisterEntities.PhysicsEntity( self )

end

function ENT:Use( ePly )

    local rand = ColorRand()

    AMB.Stats.SetStats( ePly, 'health', rand.r )
    self:SetColor( rand )

end

scripted_ents.Register( ENT, ENT.Class )