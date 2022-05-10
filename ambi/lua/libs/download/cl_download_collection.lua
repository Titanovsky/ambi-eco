Ambi.Download = Ambi.Download or {}
Ambi.Download.workshop_collections = Ambi.Download.workshop_collections or {}

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_download_workshop_collection_add', function() 
    local wid = net.ReadString()
    local collection = net.ReadTable()

    if ( hook.Call( '[Ambi.Download.CanAddCollection]', nil, wid, collection ) == false ) then return end

    Ambi.Download.workshop_collections[ wid ] = collection

    hook.Call( '[Ambi.Download.AddedCollection]', nil, wid, collection )
end )

net.Receive( 'ambi_download_workshop_collection_remove', function() 
    local wid = net.ReadString()

    if ( hook.Call( '[Ambi.Download.CanRemoveCollection]', nil, wid ) == false ) then return end

    Ambi.Download.workshop_collections[ wid ] = nil

    hook.Call( '[Ambi.Download.RemovedCollection]', nil, wid )
end )