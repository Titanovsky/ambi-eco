Ambi.UI.Render = Ambi.UI.Render or {}
local hook, render = hook, render

function Ambi.UI.Render.EnableRender()
    hook.Remove( 'PostDrawTranslucentRenderables', 'Ambi.UI.Render.DisableRender' )
end

function Ambi.UI.Render.DisableRender()
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