Ambi.General = Ambi.General or {}
Ambi.Ambition = setmetatable( Ambi.Ambition or {}, { __index = Ambi.General } ) -- for compatibility with legacy

local print, tostring, os, ipairs, concommand, PrintTable, Material = print, tostring, os, ipairs, concommand, PrintTable, Material
local _MsgC, istable, system = MsgC, istable, system
local red, green, blue, yellow, white, gray, ambi = nil

-------------------------------------------------------------------------------------------------------
function Ambi.General.OnDebug( fAction )
    if Ambi.Config.dev then return fAction() end
end

function Ambi.General.CreateModule( sTable, sVersion, sSteamIDCreator, sDescription )
    Ambi[ sTable ] = Ambi[ sTable ] or {}
    Ambi[ sTable ][ 'Config' ] = Ambi[ sTable ][ 'Config' ] or {}
    Ambi[ sTable ][ 'Meta' ] = Ambi[ sTable ][ 'Meta' ] or {}

    Ambi[ sTable ].Meta.Version = sVersion or Ambi[ sTable ].Meta.Version
    Ambi[ sTable ].Meta.Creator = sSteamIDCreator or Ambi[ sTable ].Meta.Creator
    Ambi[ sTable ].Meta.Description = sDescription or Ambi[ sTable ].Meta.Description

    if not Ambi[ sTable ].Meta then Ambi[ sTable ].Meta = {} end

    return Ambi[ sTable ], Ambi[ sTable ][ 'Config' ]
end

local consolecmds = {}
function Ambi.General.AddConsoleCommand( sCommand, fCallback, fAutoComplete, sHelpText, nFlags )
    sCommand = sCommand or 'test'
    local cmd = 'ambi_'..sCommand

    consolecmds[ sCommand ] = { command = cmd, only_server = bOnlyServer, callback = fCallback, help = sHelpText, flags = nFlags }

    return concommand.Add( cmd, fCallback, fAutoComplete, sHelpText )
end

function Ambi.General.GetConsoleCommands()
    return consolecmds
end

function Ambi.General.CheckVersion( sModule, sVersion, sURL, nDelay, fOnFail )
    if game.SinglePlayer() then return end

    nDelay = nDelay or 60 * 45

    if not ambi then
        local C = Ambi.General.Global.Colors

        red = C.ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMBI_YELLOW
        white = C.ABS_WHITE
        gray = C.AMBI_GRAY
        ambi = C.AMBI
    end

    timer.Simple( 1, function() -- workaround when server starting
        http.Fetch( sURL, function( sBody ) 
            if ( sVersion == sBody ) then MsgC( ambi, '[CheckVersion] ', white, 'The module '..sModule..' passed current version: ', green, '✔️\n' ) return end

            MsgC( ambi, '[CheckVersion] ', white, 'The module '..sModule..' don\'t passed current version, must to update: ', red, '❌\n' )

            timer.Create( 'AmbiCheckVersion:'..sModule, nDelay, 0, function()
                MsgC( ambi, '[CheckVersion] ', white, 'The module '..sModule..' don\'t passed current version, must to update: ', red, '❌\n' )

                if fOnFail then fOnFail( sBody ) end
            end )

            if fOnFail then fOnFail( sBody ) end
        end, function() 
            Ambi.General.Error( 'CheckVersion', 'The URL is not valid! Cant to check version of '..sModule )
        end )
    end )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
local logs = {}
function Ambi.General.Log( sMessage )
    if not ambi then
        local C = Ambi.General.Global.Colors

        red = C.ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMBI_YELLOW
        white = C.ABS_WHITE
        gray = C.AMBI_GRAY
        ambi = C.AMBI
    end

    sMessage = sMessage or 'Text'

    local text = '[Ambi] '..sMessage
    logs[ #logs + 1 ] = { message = text, time = os.date( '(%X)', os.time() ) }

    MsgC( ambi, '\n[Ambi] ', white, sMessage..'\n' )
end

function Ambi.General.GetLogs()
    return logs
end
Ambi.General.AddConsoleCommand( 'logs', function() PrintTable( logs ) end )

local warnings = {}
function Ambi.General.Warning( sHeader, sMessage )
    if not red then
        local C = Ambi.General.Global.Colors

        red = C.ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMBI_YELLOW
        white = C.ABS_WHITE
        gray = C.AMBI_GRAY
    end

    sHeader = sHeader or 'Header'
    sMessage = sMessage or 'Text'

    local traceback = debug.traceback()
    local text = '[Warning] ['..sHeader..'] '..sMessage
    warnings[ #warnings + 1 ] = { message = text, time = os.date( '(%X)', os.time() ), traceback = traceback }

    MsgC( yellow, '\n------------------------------------------------------------------------------------------------------\n' )
    MsgC( yellow, '[Warning] ', blue, '['..sHeader..'] ', white, '['..sMessage..']'..'\n\n' )
    MsgC( gray, traceback..'\n' )
    MsgC( yellow, '-------------------------------------------------------------------------------------------------------\n' )
end

function Ambi.General.GetWarnings()
    return warnings
end
Ambi.General.AddConsoleCommand( 'warnings', function() PrintTable( warnings ) end )

local errors = {}
function Ambi.General.Error( sHeader, sMessage )
    if not red then
        local C = Ambi.General.Global.Colors

        red = C.ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMBI_YELLOW
        white = C.ABS_WHITE
        gray = C.AMBI_GRAY
    end

    sHeader = sHeader or 'Header'
    sMessage = sMessage or 'Text'

    local traceback = debug.traceback()
    local text = '[Error] ['..sHeader..'] '..sMessage
    errors[ #errors + 1 ] = { message = text, time = os.date( '(%X)', os.time() ), traceback = traceback }

    MsgC( red, '\n------------------------------------------------------------------------------------------------------\n' )
    MsgC( red, '[Error] ', green, '['..sHeader..'] ', white, '['..sMessage..']'..'\n\n' )
    MsgC( gray, traceback..'\n' )
    MsgC( red, '-------------------------------------------------------------------------------------------------------\n' )
end

function Ambi.General.GetErrors()
    return errors
end
Ambi.General.AddConsoleCommand( 'errors', function() PrintTable( errors ) end )

function Ambi.General.CheckModule( sModule, sNameThisModule )
    if not sModule then return end
    sNameThisModule = sNameThisModule or 'this module'

    if not Ambi[ sModule ] then Ambi.General.Error( 'CheckModule', 'Module ['..sModule..'] must be connected before '..sNameThisModule ) return false end

    return true
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.General.Material( sHeader, sParam )
    return Material( 'ambi/'..sHeader, sParam )
end

function Ambi.General.Sound( sHeader )
    return 'ambi/'..sHeader
end