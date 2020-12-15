AMB.UI = AMB.UI or {}

local BLUR = Material( 'pp/blurscreen.png', 'noclamp' )

function AMB.UI.DrawBlur( dermaPanel, nBlur )

    local x, y = dermaPanel:LocalToScreen( 0, 0 )
    local w, h = ScrW(), ScrH()

    surface.SetDrawColor( 255, 255, 255 )
    surface.SetMaterial( BLUR )

    for i = 1, 3 do

        BLUR:SetFloat( '$BLUR', ( i/3 )*( nBlur or 6 ) )
        BLUR:Recompute()

        render.UpdateScreenEffectTexture()

        surface.DrawTexturedRect( x * -1, y * -1, w, h )

    end

end