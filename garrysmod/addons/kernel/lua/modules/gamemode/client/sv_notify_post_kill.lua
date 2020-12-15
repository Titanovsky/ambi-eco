AMB.Gamemode = AMB.Gamemode or {}
local CFG = AMB.Gamemode.Config

function AMB.Gamemode.NotifyPostKill( eVictim, eInflictor, eAttacker )

    if not CFG.notify_post_kill then return end

    AMB.UI.Notify.DrawNotify( eAttacker, AMB.Gamemode.Config.notify_type, { text = 'You killed '..AMB.Stats.GetStats( eVictim, 'GameName' ), time = 5, color = AMB.G.C.FLAT_RED } )

end
hook.Add( 'PlayerDeath', 'AMB.Gamemode.NotifyPostKill', AMB.Gamemode.NotifyPostKill )