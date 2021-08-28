AMB.UI.Sound = AMB.UI.Sound or {}
AMB.UI.Sound.sounds = AMB.UI.Sound.sounds or {}

local surface, net = surface, net
local PrecacheSound = util.PrecacheSound

function AMB.UI.Sound.Add( sName, sPath )
    PrecacheSound( sPath )

    AMB.UI.Sound.sounds [ sName ] = {
	    sound = sPath
    }

    return sPath
end

function AMB.UI.Sound.GetSounds()
    return AMB.UI.Sound.sounds
end

function AMB.UI.Sound.Play( sName )
    local tab = AMB.UI.Sound.sounds[ sName or '' ]
    if tab then surface.PlaySound( tab.sound ) return end

    surface.PlaySound( sName or '' )
end

net.Receive( 'amb_ui_sound_player', function() 
    local str = net.ReadString() or ''

    AMB.UI.Sound.Play( str )
end )

-- Compatibility ----------------------------------------------------------------
AMB.UI.Sounds = AMB.UI.Sound
AMB.UI.Sounds.PlaySound = AMB.UI.Sound.Play