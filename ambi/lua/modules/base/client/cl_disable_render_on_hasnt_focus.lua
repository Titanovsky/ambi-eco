local C, GUI, Draw = Ambi.Packages.Out( '@d' )
local Render = Ambi.UI.Render
local W, H = ScrW(), ScrH()
local HasFocus = system.HasFocus

local convar = CreateClientConVar( 'ambi_base_disable_render', 1, true )

hook.Add( 'HUDPaint', 'Ambi.Base.DisableRenderOnHasntFocus', function()
    if not convar:GetBool() then return end
    if not Ambi.Base.Config.disable_render_on_hasnt_focus then return end

    if HasFocus() then
        if ( Render.IsEnabled() == false ) then Render.Enable() end
    else
        Render.Disable()

        Draw.Box( W, H, 0, 0, C.ABS_BLACK )
        Draw.SimpleText( W / 2, H / 2, 'Во избежаний нагрузки на видеокарту - Рендер отключен!', '48 Arial', C.ABS_WHITE, 'center' )
    end
end )