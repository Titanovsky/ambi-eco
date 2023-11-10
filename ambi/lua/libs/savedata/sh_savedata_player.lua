local PLAYER = FindMetaTable( 'Player' )

local Gen = Ambi.General

-- ---------------------------------------------------------------------------------------------------------------------------------------
function PLAYER:SetSaveData( sNameDataBase, tValues )
    if not sNameDataBase then return end
    if not tValues then return end

    Ambi.SaveData.Set( sNameDataBase, { SteamID = self:SteamID() }, tValues )
end

function PLAYER:GetSaveData( sNameDataBase )
    return Ambi.SaveData.Get( sNameDataBase, { SteamID = self:SteamID() } )
end

function PLAYER:AutoSetSaveData( sNameDataBase, tValues )
    if not sNameDataBase then return end
    if not tValues then return end
    if not self.savedata_auto_keys then return end

    local keys = self.savedata_auto_keys[ sNameDataBase ]
    if not keys then return end

    self:SetSaveData( sNameDataBase, keys, tValues )
end

--todo PLAYER:AutoGetSetSaveData( sNameDataBase )

function PLAYER:ConfigureAutoSaveData( sNameDataBase, tKeys )
    if not sNameDataBase then return end
    if not tKeys then return end

    if not self.savedata_auto_keys then self.savedata_auto_keys = {} end

    self.savedata_auto_keys[ sNameDataBase ] = tKeys
end

function PLAYER:GetConfigAutoSaveData()
    return self.savedata_auto_keys
end
