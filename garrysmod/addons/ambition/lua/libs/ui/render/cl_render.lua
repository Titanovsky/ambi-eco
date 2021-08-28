AMB.UI.Render = AMB.UI.Render or {}
local hook, render = hook, render

function AMB.UI.Render.EnableRender()
    hook.Remove( 'PostDrawTranslucentRenderables', 'AMB.UI.Render.DisableRender' )
end

function AMB.UI.Render.DisableRender()
    hook.Add( 'PostDrawTranslucentRenderables', 'AMB.UI.Render.DisableRender', function()
        render.DepthRange(0,0.1)
        render.Clear(0,0,0,255, false,true)
        render.SuppressEngineLighting(true)
        render.ResetModelLighting(0,0,0,0)
        render.SuppressEngineLighting(false)
        render.DepthRange(0,1)
        render.OverrideDepthEnable( false, false )
    end )
end