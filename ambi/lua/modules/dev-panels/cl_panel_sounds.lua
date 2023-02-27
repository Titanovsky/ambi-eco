local C, GUI, Draw, UI, Gen = Ambi.Packages.Out( '@d, general' )
local W, H = ScrW(), ScrH()
local COLOR_TEXT = Color( 68, 64, 60 )
local COLOR_BACKGROUND = Color( 255, 254, 253 )
local COLOR_TEXT_EXTENDED = Color( 246, 221, 251)

-- --------------------------------------------------------------------------------------------------------------------------------------------
local function OpenSoundsMenu()
    local frame = GUI.DrawFrame( nil, W / 1.1, H / 1.1, 0, 0, '', true, true, true, function( self, w, h ) 
        draw.RoundedBox( 0, 0, 0, w, h, C.AMBI ) 
    end )
    frame:Center()

    local panel = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - 32, 0, 32, function( self, w, h ) 
        draw.RoundedBox( 0, 0, 0, w, h, C.AMBI_BLACK ) 
    end )

    local i = 0
    for name, path in SortedPairs( UI.Sound.GetSounds() ) do
        i = i + 1

        local j = i
        local snd = GUI.DrawButton( nil, panel:GetWide(), 46, 0, ( 46 ) * ( i - 1 ), nil, nil, nil, function( self )
            RunConsoleCommand( 'stopsound' )
            chat.AddText( name )
            SetClipboardText( name )

            timer.Simple( 0.1, function()
                surface.PlaySound( name )
            end )
        end, function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, self.color )

            Draw.SimpleText( 0, h / 2, name, UI.SafeFont( '24 Ambi' ), C.ABS_WHITE, 'center-left' )
        end )
        snd.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        snd:SetTooltip( v )
        panel:AddItem( snd )

        GUI.OnCursor( snd, function()
            snd.color = Color( 0, 0, 0, 130 )
        end, function() 
            snd.color = ( j % 2 == 0 ) and Color( 0, 0, 0, 0 ) or Color( 0, 0, 0, 50 )
        end )
    end
end
Gen.AddConsoleCommand( 'dev_sounds', OpenSoundsMenu )