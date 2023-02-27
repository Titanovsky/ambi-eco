local PLAYER = FindMetaTable( 'Player' )

-- --------------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:SetHUD( nID )
    if not nID then return end
    if ( hook.Call( '[Ambi.MultiHUD.CanSet]', nil, self, nID ) == false ) then return end

    self:RunCommand( 'ambi_'..Ambi.MultiHUD.Config.hud_command..' '..nID )

    hook.Call( '[Ambi.MultiHUD.Set]', nil, self, nID  )
end

-- --------------------------------------------------------------------------------------------------------------------------------------------
net.AddString( 'ambi_multihud_change_hud' )
net.AddString( 'ambi_multihud_show_huds' )