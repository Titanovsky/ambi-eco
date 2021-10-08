Ambi.UI.Sound = Ambi.UI.Sound or {}
Ambi.UI.Sound.sounds = Ambi.UI.Sound.sounds or {}

local surface, net = surface, net
local PrecacheSound = util.PrecacheSound

function Ambi.UI.Sound.Add( sName, sPath )
    PrecacheSound( sPath )

    Ambi.UI.Sound.sounds [ sName ] = {
	    sound = sPath
    }

    return sPath
end

function Ambi.UI.Sound.GetSounds()
    return Ambi.UI.Sound.sounds
end

function Ambi.UI.Sound.Play( sName )
    local tab = Ambi.UI.Sound.sounds[ sName or '' ]
    if tab then surface.PlaySound( tab.sound ) return end

    surface.PlaySound( sName or '' )
end

net.Receive( 'ambi_ui_sound_player', function() 
    local str = net.ReadString() or ''

    Ambi.UI.Sound.Play( str )
end )

-- Compatibility ----------------------------------------------------------------
Ambi.UI.Sounds = Ambi.UI.Sound
Ambi.UI.Sounds.PlaySound = Ambi.UI.Sound.Play