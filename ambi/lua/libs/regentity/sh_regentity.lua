Ambi.RegEntity = Ambi.RegEntity or {}

local Gen = Ambi.General

Ambi.RegEntity.ents = Ambi.RegEntity.ents or {}
Ambi.RegEntity.weps = Ambi.RegEntity.weps or {}
Ambi.RegEntity.tools = Ambi.RegEntity.tools or {}

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.RegEntity.GetEntities()
    return Ambi.RegEntity.ents
end

function Ambi.RegEntity.GetWeapons()
    return Ambi.RegEntity.weps
end

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Ambi.RegEntity.Register( sClass, sType, tEntity )
    if not sClass then Gen.Error( 'RegEntity', 'Cannot register entity without class' ) return end
    if not sType then Gen.Error( 'RegEntity', 'Cannot register entity without types: ents or weapons' ) return end
    if not istable( tEntity ) then Gen.Error( 'RegEntity', 'The third argument is not a table with data of entity' ) return end

    sType = string.lower( sType )
  
    if ( sType == 'ents' ) or ( sType == 'entities' ) or ( sType == 'sent' ) or ( sType == 'ent' ) or ( sType == 'entity' ) or ( sType == 'npc' ) then 
        Ambi.RegEntity.ents[ sClass ] = tEntity return scripted_ents.Register( tEntity, string.lower( sClass ) )
    elseif ( sType == 'weapons' ) or ( sType == 'swep' ) or ( sType == 'wep' ) or ( sType == 'gun' ) or ( sType == 'weapon' ) then 
        Ambi.RegEntity.weps[ sClass ] = tEntity return weapons.Register( tEntity, string.lower( sClass ) ) 
    elseif ( sType == 'tools' ) or ( sType == 'tool' ) then 
        return Ambi.RegEntity.AddTool( sClass, tEntity )
    end

    Gen.Error( 'RegEntity', 'Registration entity is failed, because unknow type '..sType )

    return false
end

--! This method is not work and will remove in future
function Ambi.RegEntity.Create( sClass, sPrintName, sCategory, sModel, bSpawnable, nMoveType, nPhysicInit, bEnableMotion, bWake )
    local ENT = {}

    ENT.Class = sClass
    ENT.Type = 'anim'
    ENT.PrintName	= sPrintName or sClass
    ENT.Author		= 'Ambi'
    ENT.Category	= sCategory or 'Ambi'
    ENT.Spawnable   = ( bSpawnable == nil ) and true or bSpawnable
    ENT.RenderGroup = RENDERGROUP_BOTH

    if SERVER then
        ENT.PostInit = function() end

        ENT.Initialize = function( self )
            Ambi.RegEntity.Initialize( self, sModel )
            Ambi.RegEntity.Physics( self, nMoveType, nPhysicInit, nil, bEnableMotion, bWake, not bWake )

            self.PostInit( self )
        end
    end

    return ENT
end

function Ambi.RegEntity.CreateNPC( sClass, sModel, sName, sCategory, bSpawnable )
    local ENT = {}

    ENT.Class = sClass
    ENT.Base = 'base_ai'
    ENT.Type = 'ai'
    ENT.PrintName = sName
    ENT.Category = sCategory
    ENT.Author = 'Ambi.RegEntity'
    ENT.RenderGroup = RENDERGROUP_BOTH
    ENT.Spawnable = bSpawnable
    ENT.PostInit = function() end
    ENT.PostDraw = function() end

    if SERVER then
        function ENT:Initialize()
            Ambi.RegEntity.Initialize( self, sModel )
            Ambi.RegEntity.Physics( self, MOVETYPE_NONE, SOLID_BBOX, COLLISION_GROUP_PLAYER, false, false, true )
            Ambi.RegEntity.Hull( self )
            Ambi.RegEntity.Capability( self, CAP_ANIMATEDFACE )
            Ambi.RegEntity.Capability( self, CAP_TURN_HEAD )

            self.PostInit( self )
        end
    else
        function ENT:DrawTranslucent()
            Ambi.RegEntity.Draw( self, false )

            self.PostDraw( self )
        end
    end

    return ENT
end

function Ambi.RegEntity.SimpleCreateNPC( sClass, sName, sCategory, sModel, bSpawnable, tData )
    local ENT = Ambi.RegEntity.NPC( sClass, sModel, sName, sCategory, bSpawnable )

    for k, v in pairs( tData ) do
        ENT[ k ] = v
    end

    Ambi.RegEntity.Register( sClass, 'entity', ENT )

    return ENT
end

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function FillKeys()
    local TOOL = {}

    TOOL.Mode				= nil
	TOOL.SWEP				= nil
	TOOL.Owner				= nil
	TOOL.ClientConVar		= {}
	TOOL.ServerConVar		= {}
	TOOL.Objects			= {}
	TOOL.Stage				= 0
	TOOL.Message			= 'start'
	TOOL.LastMessage		= 0
	TOOL.AllowedCVar		= 0

    function TOOL:UpdateData() 
        self:SetStage( self:NumObjects() ) 
    end
    
    function TOOL:SetStage( i ) 
        if ( SERVER ) then self:GetWeapon():SetNWInt( 'Stage', i, true ) end 
    end

    function TOOL:GetStage()
        return self:GetWeapon():GetNWInt( 'Stage', 0 )
    end
    
    function TOOL:SetOperation( i )
        if ( SERVER ) then
            self:GetWeapon():SetNWInt( 'Op', i, true )
        end
    end
    
    function TOOL:GetOperation()
        return self:GetWeapon():GetNWInt( 'Op', 0 )
    end

    function TOOL:ClearObjects()
        self:ReleaseGhostEntity()
        self.Objects = {}
        self:SetStage( 0 )
        self:SetOperation( 0 )
    end

    function TOOL:GetEnt( i )
        if ( !self.Objects[i] ) then return NULL end
    
        return self.Objects[i].Ent
    end

    function TOOL:GetPos( i )
        if ( self.Objects[i].Ent:EntIndex() == 0 ) then
            return self.Objects[i].Pos
        else
            if IsValid( self.Objects[i].Phys ) then
                return self.Objects[i].Phys:LocalToWorld( self.Objects[i].Pos )
            else
                return self.Objects[i].Ent:LocalToWorld( self.Objects[i].Pos )
            end
        end
    end

    function TOOL:GetLocalPos( i )
        return self.Objects[i].Pos
    end

    function TOOL:GetBone( i )
        return self.Objects[i].Bone
    end

    function TOOL:GetNormal( i )
        if ( self.Objects[i].Ent:EntIndex() == 0 ) then
            return self.Objects[i].Normal
        else
            local norm
            if ( IsValid( self.Objects[i].Phys ) ) then
                norm = self.Objects[i].Phys:LocalToWorld( self.Objects[i].Normal )
            else
                norm = self.Objects[i].Ent:LocalToWorld( self.Objects[i].Normal )
            end
    
            return norm - self:GetPos(i)
        end
    end

    function TOOL:GetPhys( i )
        if ( self.Objects[i].Phys == nil ) then
            return self:GetEnt(i):GetPhysicsObject()
        end
    
        return self.Objects[i].Phys
    end

    function TOOL:SetObject( i, ent, pos, phys, bone, norm )
        self.Objects[i] = {}
        self.Objects[i].Ent = ent
        self.Objects[i].Phys = phys
        self.Objects[i].Bone = bone
        self.Objects[i].Normal = norm
    
        -- Worldspawn is a special case
        if ( ent:EntIndex() == 0 ) then
            self.Objects[i].Phys = nil
            self.Objects[i].Pos = pos
        else
            norm = norm + pos
    
            -- Convert the position to a local position - so it's still valid when the object moves
            if ( IsValid( phys ) ) then
                self.Objects[i].Normal = self.Objects[i].Phys:WorldToLocal( norm )
                self.Objects[i].Pos = self.Objects[i].Phys:WorldToLocal( pos )
            else
                self.Objects[i].Normal = self.Objects[i].Ent:WorldToLocal( norm )
                self.Objects[i].Pos = self.Objects[i].Ent:WorldToLocal( pos )
            end
        end
    end

    function TOOL:NumObjects()
        if ( CLIENT ) then return self:GetStage() end
    
        return #self.Objects
    end

    function TOOL:GetHelpText()
        return "#tool." .. GetConVarString( "gmod_toolmode" ) .. "." .. self:GetStage()
    end

    if CLIENT then
        function TOOL:FreezeMovement()
            return false 
        end
        
        function TOOL:DrawHUD()
        end
    end

    function TOOL:CreateConVars()
        local mode = self:GetMode()
    
        if ( CLIENT ) then
            for cvar, default in pairs( self.ClientConVar ) do
                CreateClientConVar( mode .. "_" .. cvar, default, true, true )
            end
    
            return
        end
    
        if ( SERVER ) then
            self.AllowedCVar = CreateConVar( "toolmode_allow_" .. mode, 1, FCVAR_NOTIFY )
    
            for cvar, default in pairs( self.ServerConVar ) do
                CreateConVar( mode .. "_" .. cvar, default, FCVAR_ARCHIVE )
            end
        end
    end

    function TOOL:GetServerInfo( property )
        local mode = self:GetMode()
    
        return GetConVarString( mode .. "_" .. property )
    end

    function TOOL:BuildConVarList()
        local mode = self:GetMode()
        local convars = {}
    
        for k, v in pairs( self.ClientConVar ) do convars[ mode .. "_" .. k ] = v end
    
        return convars
    end

    function TOOL:GetClientInfo( property )
        return self:GetOwner():GetInfo( self:GetMode() .. "_" .. property )
    end

    function TOOL:GetClientNumber( property, default )
        return self:GetOwner():GetInfoNum( self:GetMode() .. "_" .. property, tonumber( default ) or 0 )
    end
    
    function TOOL:Allowed()
        if ( CLIENT ) then return true end
        return self.AllowedCVar:GetBool()
    end

    function TOOL:Init() end
    function TOOL:GetMode()		return self.Mode end
    function TOOL:GetSWEP()		return self.SWEP end
    function TOOL:GetOwner()		return self:GetSWEP().Owner or self.Owner end
    function TOOL:GetWeapon()	return self:GetSWEP().Weapon or self.Weapon end
    function TOOL:LeftClick()	return false end
    function TOOL:RightClick()	return false end
    function TOOL:Reload()		self:ClearObjects() end
    function TOOL:Deploy()		self:ReleaseGhostEntity() return end
    function TOOL:Holster()		self:ReleaseGhostEntity() return end
    function TOOL:Think()		self:ReleaseGhostEntity() end

    function TOOL:CheckObjects()
        for k, v in pairs( self.Objects ) do
            if ( !v.Ent:IsWorld() && !v.Ent:IsValid() ) then
                self:ClearObjects()
            end
        end
    end

    function TOOL:MakeGhostEntity( model, pos, angle )
        util.PrecacheModel( model )
    
        if ( SERVER && !game.SinglePlayer() ) then return end
        if ( CLIENT && game.SinglePlayer() ) then return end

        if not IsFirstTimePredicted() then return end
    
        self:ReleaseGhostEntity()
    
        if not util.IsValidProp( model ) then return end
    
        if ( CLIENT ) then
            self.GhostEntity = ents.CreateClientProp( model )
        else
            self.GhostEntity = ents.Create( 'prop_physics' )
        end

        if not IsValid( self.GhostEntity ) then self.GhostEntity = nil return end
    
        self.GhostEntity:SetModel( model )
        self.GhostEntity:SetPos( pos )
        self.GhostEntity:SetAngles( angle )
        self.GhostEntity:Spawn()

        self.GhostEntity:PhysicsDestroy()
        self.GhostEntity:SetMoveType( MOVETYPE_NONE )
        self.GhostEntity:SetNotSolid( true )
        self.GhostEntity:SetRenderMode( RENDERMODE_TRANSCOLOR )
        self.GhostEntity:SetColor( Color( 255, 255, 255, 150 ) )
    end

    function TOOL:StartGhostEntity( ent )
        if ( SERVER && !game.SinglePlayer() ) then return end
        if ( CLIENT && game.SinglePlayer() ) then return end
    
        self:MakeGhostEntity( ent:GetModel(), ent:GetPos(), ent:GetAngles() )
    end
    
    function TOOL:ReleaseGhostEntity()
        if self.GhostEntity then
            if ( !IsValid( self.GhostEntity ) ) then self.GhostEntity = nil return end
            self.GhostEntity:Remove()
            self.GhostEntity = nil
        end
    
        if self.GhostEntities then
            for k,v in pairs( self.GhostEntities ) do
                if IsValid( v ) then v:Remove() end
                self.GhostEntities[ k ] = nil
            end
    
            self.GhostEntities = nil
        end
    
        if self.GhostOffset then
            for k,v in pairs( self.GhostOffset ) do
                self.GhostOffset[ k ] = nil
            end
        end
    end
    
    function TOOL:UpdateGhostEntity()
        if ( self.GhostEntity == nil ) then return end
        if ( !IsValid( self.GhostEntity ) ) then self.GhostEntity = nil return end
    
        local trace = self:GetOwner():GetEyeTrace()
        if not trace.Hit then return end
    
        local Ang1, Ang2 = self:GetNormal( 1 ):Angle(), ( trace.HitNormal * -1 ):Angle()
        local TargetAngle = self:GetEnt( 1 ):AlignAngles( Ang1, Ang2 )
    
        self.GhostEntity:SetPos( self:GetEnt( 1 ):GetPos() )
        self.GhostEntity:SetAngles( TargetAngle )
    
        local TranslatedPos = self.GhostEntity:LocalToWorld( self:GetLocalPos( 1 ) )
        local TargetPos = trace.HitPos + ( self:GetEnt( 1 ):GetPos() - TranslatedPos ) + trace.HitNormal
    
        self.GhostEntity:SetPos( TargetPos )
    end

    return TOOL
end

function Ambi.RegEntity.AddTool( tTool )
    local TOOL = {}
    TOOL = FillKeys()

    for key, value in pairs( tTool ) do
        TOOL[ key ] = value
    end

    if not TOOL.Mode then return end

    if CLIENT then
        local phrases = TOOL.Phrases
        local mode = TOOL.Mode

        language.Add( 'tool.'..mode..'.name', TOOL.Name or phrases.name )

        if phrases then
            for i, v in pairs( phrases ) do
                language.Add( 'tool.'..mode..'.'..i, v )
            end
        end
    end

    TOOL:CreateConVars()

    timer.Simple( 0.1, function() weapons.GetStored( 'gmod_tool' )[ 'Tool' ][ TOOL.Mode ] = TOOL end )

    Ambi.RegEntity.tools[ TOOL.Mode ] = TOOL

    if SERVER then
        -- Workaround: из-за ебанутой системы SWEP, нужно у игрока убирать оружие и давать заново
        for _, ply in ipairs( player.GetAll() ) do
            if ply:HasWeapon( 'gmod_tool' ) then 
                local is_select = ( IsValid( ply:GetActiveWeapon() ) and ( ply:GetActiveWeapon():GetClass() == 'gmod_tool' ) ) and true or false
                ply:StripWeapon( 'gmod_tool' )

                timer.Simple( 0.15, function() 
                    if IsValid( ply ) and ply:Alive() then 
                        ply:Give( 'gmod_tool' ) 

                        if is_select then ply:SelectWeapon( ply:GetWeapon( 'gmod_tool' ) ) end
                    end
                end )
            end
        end
    end

    return TOOL
end

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    hook.Add( 'PopulateToolMenu', 'Ambi.RegEntity.AddTools', function()
        for mode, tool in pairs( Ambi.RegEntity.tools ) do
            if tool.AddToMenu then continue end

            spawnmenu.AddToolMenuOption( 
                tool.Tab or 'Main',
                tool.Category or 'Ambi',
                mode,
                tool.Name or '['..mode..']',
                tool.Command or 'gmod_tool '..mode,
                tool.ConfigName or mode,
                tool.BuildCPanel 
            )
        end
    end )
end

hook.Add( 'PostGamemodeLoaded', 'Ambi.RegEntity.AddTools', function() 
    for mode, tool in pairs( Ambi.RegEntity.tools ) do
        weapons.GetStored( 'gmod_tool' )[ 'Tool' ][ mode ] = tool
    end
end )