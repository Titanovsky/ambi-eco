local C, GUI, Draw, UI, Lang = Ambi.Packages.Out( '@d, language' )
local W, H = ScrW(), ScrH()
local HALF_W, HALF_H = W / 2, H / 2

local HasFocus = system.HasFocus
local convar = CreateClientConVar( 'ambi_disable_render_unfocus', 1, true )

-- --------------------------------------------------------------------------------------------------------------------------------------------
Lang.SimpleAdd( 'disable_render_unfocus_text', 'Во избежаний нагрузки на видеокарту - Рендер отключен!', 'To avoid the heavy load, the server is turned off!' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PreRender', 'Ambi.DisableRenderUnfocused', function()
    if not convar:GetBool() then return end
    if HasFocus() then return end

    cam.Start2D()
        Draw.Box( W, H, 0, 0, C.ABS_BLACK )
        Draw.SimpleText( HALF_W, HALF_H, Lang.Get( 'disable_render_unfocus_text' ), UI.SafeFont( '32 Ambi' ), C.ABS_WHITE, 'center' )
    cam.End2D()

    return true
end )