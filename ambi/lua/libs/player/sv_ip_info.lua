local PLAYER = FindMetaTable( 'Player' )
local Error, Warning, Log, Fetch = Ambi.General.Error, Ambi.General.Warning, Ambi.General.Log, http.Fetch
local DEFAULT_RETRIES = 2

-- --------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:RequestIPAPI( fAction )
    if self:IsBot() then return end
    
	Fetch( 'https://ipapi.co/'..self:IP()..'/json', function( sBody )
		local tab = util.JSONToTable( sBody )

		if fAction then fAction( tab ) end
	end, function( sCode ) 
        Error( 'Ambi.Player', 'Error request in ipapi.co: '..sCode ) 
    end )
end

function PLAYER:MakeIPInfoTable( nRetry )
    nRetry = nRetry or DEFAULT_RETRIES
	if ( nRetry <= 0 ) then return end

    self:RequestIPAPI( function( tTab )
        self.ip_info = tTab
    end )

    timer.Simple( 1, function()
        if not IsValid( self ) then return end
        if self.ip_info then Log( 'IPInfo table for '..self:SteamID()..' has maked' ) return end

		self:MakeIPInfoTable( nRetry - 1 )
	end )
end

function PLAYER:GetIPInfo()
    return self.ip_info
end

function PLAYER:GetIPInfoCity()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.city
end

function PLAYER:GetIPInfoRegion()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.region
end

function PLAYER:GetIPInfoRegionCode()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.region_code
end

function PLAYER:GetIPInfoCountry()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country
end

function PLAYER:GetIPInfoCountryName()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_name
end

function PLAYER:GetIPInfoCountryCode()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_code
end

function PLAYER:GetIPInfoCountryCodeISO3()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_code_iso3
end

function PLAYER:GetIPInfoCapital()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_capital
end

function PLAYER:GetIPInfoTLD()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_tld
end

function PLAYER:GetIPInfoContinentCode()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.continent_code
end

function PLAYER:GetIPInfoTimezone()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.timezone
end

function PLAYER:GetIPInfoCallingCode()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.country_calling_code
end

function PLAYER:GetIPInfoCurrency()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.currency
end

function PLAYER:GetIPInfoCurrencyName()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.currency_name
end

function PLAYER:GetIPInfoInternetProvider()
    if not self:GetIPInfo() then self:MakeIPInfoTable() Warning( 'Ambi.Player', 'The table ip_info dont exists, will be create.' ) return end

    return self.ip_info.org
end