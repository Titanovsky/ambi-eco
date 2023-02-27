local Error, Warn = Ambi.General.Error, Ambi.General.Warning

local function SpawnEntity( sClass, vPos, aAng, fPost )
    local ent = ents.Create( sClass )
    ent:SetPos( vPos or Vector( 0, 0, 0 ) )
    ent:SetAngles( aAng or Angle( 0, 0, 0 ) )
    ent:Spawn()

    timer.Simple( 0.35, function()
        if fPost and IsValid( ent ) then fPost( ent ) end
    end )

    return ent
end

function Ambi.AutoSpawn.RemoveOldEntity( sMark )
    local obj = Ambi.AutoSpawn.Config.list[ sMark ]
    if not obj then return end

    if IsValid( obj.ent ) then obj.ent:Remove() end
end

function Ambi.AutoSpawn.Add( sMark, sClass, sDescription, sMap, vPos, aAng, fPost, bBlockSpawnPostCleanup )
    if ( sMark == nil ) then Error( 'AutoSpawn', 'sMark not selected' ) return end
    if ( sClass == nil ) then Error( 'AutoSpawn', 'sClass not selected' ) return end
    if sMap and ( sMap ~= game.GetMap() ) then return end

    if ( vPos == nil ) or ( isvector( vPos ) == false ) then Warn( 'AutoSpawn', 'vPos not selected or is not a vector' ) end
    if ( aAng == nil ) or ( isangle( aAng ) == false ) then Warn( 'AutoSpawn', 'aAng not selected or is not a angle' ) end
    if ( sDescription == nil ) or ( isstring( sDescription ) == false ) then Warn( 'AutoSpawn', 'sDescription not selected or is not a string' ) end

    timer.Simple( 0.11, function()
        Ambi.AutoSpawn.RemoveOldEntity( sMark )
        Ambi.AutoSpawn.Config.list[ sMark ] = {
            map = sMap,
            class = sClass,
            pos = vPos or Vector( 0, 0, 0 ),
            ang = aAng or Angle( 0, 0, 0 ),
            desc = sDescription or '',
            ent = SpawnEntity( sClass, vPos, aAng, fPost ),
            blockspawn = bBlockSpawnPostCleanup,
            post = fPost,
        }

        print( '[AutoSpawn] Spawned '..sClass..' ('..sMark..')' )
    end )
end

function AMB.AutoSpawn.SpawnAll()
    for mark, tab in pairs( Ambi.AutoSpawn.Config.list ) do 
        Ambi.AutoSpawn.Add( mark, tab.class, tab.desc, tab.map, tab.pos, tab.ang, tab.post ) 
    end
end
hook.Add( 'PostCleanupMap', 'AMB.AutoSpawn.Spawn', function() 
    for mark, tab in pairs( Ambi.AutoSpawn.Config.list ) do 
        if tab.blockspawn then continue end
        Ambi.AutoSpawn.Add( mark, tab.class, tab.desc, tab.map, tab.pos, tab.ang, tab.post ) 
    end
end )