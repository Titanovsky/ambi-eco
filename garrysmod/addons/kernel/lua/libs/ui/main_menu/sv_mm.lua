AMB.UI.MainMenu = AMB.UI.MainMenu or {}
CFG = AMB.UI.MainMenu.Config

hook.Add( 'ShowSpare2', 'AMB.UI.MainMenu.ShowMenuOnF4', function( ePly )

    if CFG.call_on_f4 then  

        net.Start( CFG.net_f4 )
        net.Send( ePly )

    end

end )
