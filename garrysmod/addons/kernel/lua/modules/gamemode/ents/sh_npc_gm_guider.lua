local ENT = {}

ENT.Class       = 'amb_gm_guider'
ENT.Base	    = 'base_ai'
ENT.Type	    = 'ai'

ENT.PrintName	= 'NPC Guider'
ENT.Author		= AMB.G.AUTHOR
ENT.Category	= AMB.G.Category( 'Ambition' )
ENT.Spawnable   = true

scripted_ents.Register( ENT, ENT.Class )

if CLIENT then

    ENT.RenderGroup = AMB.G.RENDER

    local w = ScrW()
    local h = ScrH()

    local function ShowGuide()

        local frame = vgui.Create( 'DFrame' )
        frame:SetSize( w/1.4, h/1.4 )
        frame:Center()
        frame:SetDraggable( false )
        frame:MakePopup()
        frame:SetTitle( 'Help Menu' )
        
        surface.PlaySound( 'ui/buttonclick.wav' )

    end
    concommand.Add( 'amb_guide', ShowGuide )

    function ENT:DrawTranslucent()

        AMB.RegisterEntities.DrawEntity( self, false )

    end

    scripted_ents.Register( ENT, ENT.Class )

    return

end

function ENT:Initialize()

    AMB.RegisterEntities.InitNPC( self, 'models/Eli.mdl' )
    AMB.RegisterEntities.BehaviorNPC( self )
    AMB.RegisterEntities.PhysicsNPC( self )

end

function ENT:Use( ePly )

    ePly:ConCommand( 'amb_guide' )

end

scripted_ents.Register( ENT, ENT.Class )