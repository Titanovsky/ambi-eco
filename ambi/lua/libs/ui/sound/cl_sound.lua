Ambi.UI.Sound = Ambi.UI.Sound or {}
Ambi.UI.Sound.sounds = Ambi.UI.Sound.sounds or {}

-- --------------------------------------------------------------------------------------------------------------------------------------------
local surface, net = surface, net
local PrecacheSound = util.PrecacheSound
local C = Ambi.General.Global.Colors

-- --------------------------------------------------------------------------------------------------------------------------------------------
local surface_PlaySound = surface.PlaySound -- DON'T RESAVE THIS FILE, WHEN YOUR SERVER WORKING!
function surface.PlaySound( sName )
    sName = Ambi.UI.Sound.sounds[ sName ] or sName

    return surface_PlaySound( sName )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.UI.Sound.Add( sName, sPath )
    PrecacheSound( sPath )

    Ambi.UI.Sound.sounds [ sName ] = sPath

    return sPath
end

function Ambi.UI.Sound.GetSounds()
    return Ambi.UI.Sound.sounds
end

function Ambi.UI.Sound.Play( sName )
    surface.PlaySound( sName )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_ui_sound_player', function() 
    local str = net.ReadString()

    Ambi.UI.Sound.Play( str )
end )