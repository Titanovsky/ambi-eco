local ENT = {}

ENT.Class       = 'amb_gm_box'
ENT.Type	    = 'anim'

ENT.PrintName	= 'The Box'
ENT.Author		= AMB.G.AUTHOR
ENT.Category	= AMB.G.Category( 'Ambition' )
ENT.Spawnable   = true

scripted_ents.Register( ENT, ENT.Class )

if CLIENT then

    ENT.RenderGroup = AMB.G.RENDER

    ENT.DrawTranslucent = function( self )

        AMB.RegisterEntities.DrawEntity( self, false )

    end

    scripted_ents.Register( ENT, ENT.Class )

    return

end 

ENT.Initialize = function( self )

    AMB.RegisterEntities.InitEntity( self, 'models/maxofs2d/cube_tool.mdl' )
    AMB.RegisterEntities.PhysicsEntity( self )

end

ENT.Touch = function( self, ePly )

    ePly:SetVelocity( ePly:GetAimVector() * -500 )

end

scripted_ents.Register( ENT, ENT.Class )