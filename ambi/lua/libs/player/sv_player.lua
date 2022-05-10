local AddString = Ambi.General.Network.AddString
local PLAYER = FindMetaTable( 'Player' )
local net = net
local Error, Get = Ambi.General.Error, http.Fetch

-- --------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:IP()
    return self:IPAddress():StripPort()
end

function PLAYER:GetIP()
    return self:IPAddress():StripPort()
end

function PLAYER:GetIPInfo( fAction )
    if self:IsBot() then return end
    
	Get( 'https://ipapi.co/'..self:IP()..'/json', function( sBody )
		local tab = util.JSONToTable( sBody )

		if fAction then fAction( tab ) end

        self.real_info = tab
	end, function( sCode ) print( '[GetIPInfo] Error: '..sCode ) end )

	return self.real_info
end

function PLAYER:GetCity()
    return self.real_info.city
end

function PLAYER:GetRegion()
    return self.real_info.region
end

function PLAYER:GetRegionCode()
    return self.real_info.region_code
end

function PLAYER:GetCountry()
    return self.real_info.country
end

function PLAYER:GetCountryName()
    return self.real_info.country_name
end

function PLAYER:GetCountryCode()
    return self.real_info.country_code
end

function PLAYER:GetCountryCodeISO3()
    return self.real_info.country_code_iso3
end

function PLAYER:GetCapital()
    return self.real_info.country_capital
end

function PLAYER:GetTLD()
    return self.real_info.country_tld
end

function PLAYER:GetContinentCode()
    return self.real_info.continent_code
end

function PLAYER:GetTimezone()
    return self.real_info.timezone
end

function PLAYER:GetCallingCode()
    return self.real_info.country_calling_code
end

function PLAYER:GetCurrency()
    return self.real_info.currency
end

function PLAYER:GetCurrencyName()
    return self.real_info.currency_name
end

function PLAYER:GetInternetProvider()
    return self.real_info.org
end

-- --------------------------------------------------------------------------------------------------------------------------------------
local net_str = AddString( 'ambi_player_run_command' )
function PLAYER:RunCommand( sText )
    net.Start( net_str )
        net.WriteString( sText or '' )
    net.Send( self )
end

local net_str = AddString( 'ambi_player_open_url' )
function PLAYER:OpenURL( sURL )
    net.Start( net_str )
        net.WriteString( sURL or '' )
    net.Send( self )
end

-- --------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Player.GetIPInfo', function( ePly ) 
    if game.SinglePlayer() then return end
    
    timer.Simple( 1, function()
        if not IsValid( ePly ) then return end

        ePly:GetIPInfo() -- create ePly.real_info
    end )
end )