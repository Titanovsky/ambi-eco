local C, GUI, Draw, UI = Ambi.Packages.Out( '@design' )
local W, H = ScrW(), ScrH()

-- ---------------------------------------------------------------------------------------------------------------------------------------
UI.SimpleAddFont( 'Process', 'Franklin Gothic Demi', 'for MultiHUD', 26 )
UI.SimpleAddFont( 'Process', 'Franklin Gothic Demi', 'for MultiHUD', 24 )

-- ---------------------------------------------------------------------------------------------------------------------------------------
local process
function Ambi.Process.ShowProcess( sName, sDescription, nTime )
    sName = sName or ''
    sDescription = sDescription or ''
    nTime = nTime or 0.5
    
    local frame = GUI.DrawPanel( nil, 260, 80, W / 2 - 260 / 2, 12, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.FLAT_GREEN )
        Draw.Box( w - 4, h - 4, 2, 2, C.ABS_WHITE )

        if not timer.Exists( 'AmbiProcess' ) then self:Remove() return end

        Draw.Text( w / 2, 4, sName..'..', '26 Process', C.ABS_BLACK, 'top-center' ) 
        Draw.Text( w / 2, h - 4, tostring( math.floor( timer.TimeLeft( 'AmbiProcess' ) ) ), '24 Process', C.ABS_BLACK, 'bottom-center' )
        Draw.Text( w / 2, 4 + 26 + 2, sDescription, UI.SafeFont( '18 Arial' ), C.FLAT_SILVER, 'top-center' )
        Draw.Text( 4, h - 4, 'Cancel [F2]', UI.SafeFont( '14 Arial' ), C.AMB_BLOOD, 'bottom-left' )
    end )

    frame:SetKeyboardInputEnabled( true )
    frame:SetMouseInputEnabled( true )
    
    frame.Think = function( self )
        if not LocalPlayer():IsProcess() then return end

        if input.IsKeyDown( KEY_F2 ) then
            net.Start( 'ambi_process_break' )
            net.SendToServer()

            return self:Remove() 
        end
    end

    process = frame

    timer.Create( 'AmbiProcess', nTime + 0.55, 1, function()
        LocalPlayer().process = false

        if ValidPanel( frame ) then frame:Remove() return end
    end )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_process_start', function()
    local name = net.ReadString()
    local desc = net.ReadString()
    local time = net.ReadFloat()

    Ambi.Process.ShowProcess( name, desc, time )
    LocalPlayer().process = true
end )

net.Receive( 'ambi_process_stop', function()
    if process and ValidPanel( process ) then 
        timer.Remove( 'AmbiProcess' )

        process:Remove() 
    end
end )