local C, GUI, Sounds = Ambi.General.Global.Colors, Ambi.UI.GUI, Ambi.UI.Sounds
local Notify = Ambi.UI.Notify

local w = ScrW()
local h = ScrH()

local now_notify = {}

Notify.Add( 2, 'Minimalistic Notify', 'Ambi', function( tVars )
    now_notify[ #now_notify+1 ] = 0
    local ID = #now_notify

    local time          = tVars.time or 4
    local text          = tVars.text or ''
    local color_point   = tVars.color or C.ABS_WHITE
    local sound         = tVars.sound or false

    surface.SetFont( '18 Ambi' )
    local xchar, _ = surface.GetTextSize( text )

    if sound then Sounds.PlaySound( sound ) end

    local notify = GUI.DrawPanel( nil, 0, 28, w - xchar - 22 - 4, h-155-ID*30, function( self, w, h ) 
        draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK )
        draw.RoundedBox( 0, w-8, 0, 12, h, color_point )
        draw.SimpleTextOutlined( text, '18 Ambi', 8, h/2, C.ABS_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, C.ABS_BLACK )
    end )
    notify:SizeTo( xchar + 22, 28, 0.25, 0, -1, function() end )

    timer.Simple( time, function() 
        notify:SizeTo( 0, 28, 0.25, 0, -1, function() 
            notify:Remove() 
            now_notify[ ID ] = nil
        end )
    end )

    Notify.AddLog( text )
end )