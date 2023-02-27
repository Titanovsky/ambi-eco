local AddString = Ambi.General.Network.AddString
local PLAYER = FindMetaTable( 'Player' )

-- --------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:GetIP()
    return self:IPAddress():StripPort()
end

function PLAYER:IP()
    return self:GetIP()
end

local net_str = AddString( 'ambi_player_run_command' )
function PLAYER:RunCommand( sText )
    net.Start( net_str )
        net.WriteString( sText )
    net.Send( self )
end

function PLAYER:ConCommand( sText )
    net.Start( net_str )
        net.WriteString( sText )
    net.Send( self )
end

local net_str = AddString( 'ambi_player_open_url' )
function PLAYER:OpenURL( sURL )
    net.Start( net_str )
        net.WriteString( sURL )
    net.Send( self )
end

local net_str = AddString( 'ambi_player_set_clipboard_text' )
function PLAYER:SetClipboardText( sText )
    net.Start( net_str )
        net.WriteString( sText )
    net.Send( self )
end