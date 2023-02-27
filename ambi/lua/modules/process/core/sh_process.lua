Ambi.Process.processes = Ambi.Process.processes or {}

local PLAYER = FindMetaTable( 'Player' )

function PLAYER:IsProcess()
    return tobool( self.process )
end

function PLAYER:GetProcess()
    return self.process
end