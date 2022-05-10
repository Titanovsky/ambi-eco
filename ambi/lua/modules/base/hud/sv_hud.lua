local PLAYER = FindMetaTable( 'Player' )

function PLAYER:SetHUD( nID )
    if not nID then return end

    self:RunCommand( 'ambi_'..Ambi.Base.Config.hud_command..' '..nID )
end