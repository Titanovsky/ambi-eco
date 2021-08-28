local PrintTable, Fetch, GMatch, tostring = PrintTable, http.Fetch, string.gmatch, tostring

function AMB.Download.Collection( sWorkshopID )
    if ( sWorkshopID == nil ) then return end
    sWorkshopID = tostring( sWorkshopID )

    Fetch( 'https://steamcommunity.com/sharedfiles/filedetails/?id='..sWorkshopID, function( sBody )
        local tab = {}

        for v in GMatch( sBody, 'SharedFileBindMouseHover%(.-%)' ) do
            tab[ #tab + 1 ] = v
        end

        PrintTable( tab )
    end )
end