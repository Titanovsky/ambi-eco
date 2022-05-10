Ambi.UI.Render = Ambi.UI.Render or {}
local hook, render = hook, render

local is_disabled = false

function Ambi.UI.Render.Enable()
    if not is_disabled then return end

    is_disabled = false

    hook.Remove( 'PostDrawTranslucentRenderables', 'Ambi.UI.Render.DisableRender' )
end

function Ambi.UI.Render.Disable()
    if is_disabled then return end

    is_disabled = true

    hook.Add( 'PostDrawTranslucentRenderables', 'Ambi.UI.Render.DisableRender', function()
        render.DepthRange(0,0.1)
        render.Clear(0,0,0,255, false,true)
        render.SuppressEngineLighting(true)
        render.ResetModelLighting(0,0,0,0)
        render.SuppressEngineLighting(false)
        render.DepthRange(0,1)
        render.OverrideDepthEnable( false, false )
    end )
end

function Ambi.UI.Render.IsEnabled()
    return not is_disabled
end