local PrintTable, Fetch, GMatch, tostring = PrintTable, http.Fetch, string.gmatch, tostring
local Error = Ambi.General.Error

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Download.LoadWorkshopCollection( sWorkshopID )
    timer.Simple( 1, function()
        if ( hook.Call( '[Ambi.Download.CanLoadWorkshopCollection]', nil, sWorkshopID ) == false ) then return end

        Ambi.Download.GetWorkshopCollection( sWorkshopID, function( tCollection ) 
            for _, addon in ipairs( tCollection ) do
                local title, id = addon.title, addon.id
        
                resource.AddWorkshop( id )
                print( '[Workshop] Added ['..id..'] ['..title..']' )

                hook.Call( '[Ambi.Download.LoadedWorkshopCollection]', nil, sWorkshopID )
            end
        end )
    end )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
util.AddNetworkString( 'ambi_download_workshop_collection_add' )
function Ambi.Download.AddCollection( sWorkshopID )
    timer.Simple( 1, function()
        if not sWorkshopID then Error( 'Download', 'AddCollection | not sWorkshopID' ) return end

        Ambi.Download.GetWorkshopCollection( sWorkshopID, function( tCollection ) 
            if not tCollection then Error( 'Download', 'AddCollection | not tCollection' ) return end
            if ( hook.Call( '[Ambi.Download.CanAddCollection]', nil, sWorkshopID, tCollection ) == false ) then return end

            Ambi.Download.workshop_collections[ sWorkshopID ] = tCollection

            net.Start( 'ambi_download_workshop_collection_add' )
                net.WriteString( sWorkshopID )
                net.WriteTable( tCollection )
            net.Broadcast()

            hook.Call( '[Ambi.Download.AddedCollection]', nil, sWorkshopID, tCollection )
        end )
    end )
end

util.AddNetworkString( 'ambi_download_workshop_collection_remove' )
function Ambi.Download.RemoveCollection( sWorkshopID )
    if not sWorkshopID then return end
    if ( hook.Call( '[Ambi.Download.CanRemoveCollection]', nil, sWorkshopID ) == false ) then return end

    Ambi.Download.workshop_collections[ sWorkshopID ] = nil

    net.Start( 'ambi_download_workshop_collection_remove' )
        net.WriteString( sWorkshopID )
    net.Broadcast()

    hook.Call( '[Ambi.Download.RemovedCollection]', nil, sWorkshopID )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
hook.Add( 'PlayerInitialSpawn', 'Ambi.Download.SendClientsTable', function( ePly ) 
    for collection_id, collection in pairs( Ambi.Download.GetCollections() ) do
        net.Start( 'ambi_download_add' )
            net.WriteString( collection_id )
            net.WriteTable( collection )
        net.Send( ePly )
    end
end )