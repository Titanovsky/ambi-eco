Ambi.Download = Ambi.Download or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
local http_fetch, string_gmatch, tostring = http.Fetch, string.gmatch, tostring

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Download.GetWorkshopCollection( sWorkshopID, fAction )
    if ( sWorkshopID == nil ) then return end

    sWorkshopID = tostring( sWorkshopID )

    http_fetch( 'https://steamcommunity.com/sharedfiles/filedetails/?id='..sWorkshopID, function( sBody )
        if not sBody then return end
        
        local tab = {}
        local ex = {}
        local final = {}

        for v in string_gmatch( sBody, 'SharedFileBindMouseHover%(.-%)' ) do
            tab[ #tab + 1 ] = v
        end

        for i, v in ipairs( tab ) do
            final[ i ] = {}

            local subtab = final[ i ]

            for str in string_gmatch( v, '".-"' ) do
                subtab[ #subtab + 1 ] = str
            end
        end

        local tab = {}
        for i, v in ipairs( final ) do
            tab[ i ] = { title = string.IsValid( v[ 5 ] ) and string.Replace( v[ 5 ], '"', '' ) or 'No Title', id = tonumber( string.Replace( v[ 3 ], '"', '' ) ) }
        end

        if fAction then fAction( tab, sBody ) end

        hook.Call( '[Ambi.Download.GetWorkshopCollection]', sWorkshopID, tab, fAction )
    end, function( sCode ) 
        print( '[Download] Error: '..sCode ) 
    end )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
Ambi.Download.workshop_collections = Ambi.Download.workshop_collections or {}

function Ambi.Download.GetCollection( sWorkshopID )
    if not sWorkshopID then return end

    return Ambi.Download.workshop_collections[ sWorkshopID ]
end

function Ambi.Download.GetCollections()
    return Ambi.Download.workshop_collections
end