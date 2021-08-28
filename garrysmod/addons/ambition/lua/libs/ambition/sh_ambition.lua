AMB.Ambition = AMB.Ambition or {}
local print, tostring, os, ipairs, concommand, PrintTable, Material = print, tostring, os, ipairs, concommand, PrintTable, Material
local _MsgC, istable, system = MsgC, istable, system

-------------------------------------------------------------------------------------------------------
function AMB.Ambition.OnDebug( fAction )
    if AMB.Config.dev then return fAction() end
end

local COLOR_CLEAR_SEQUENCE = '\27[0m'
function AMB.Ambition.Print( ... )
    local args = { ... }

    if system.IsLinux() then
        -- Source: https://github.com/SuperiorServers/dash/blob/a0d4347371503b1577d72bed5f6df46d48909f56/lua/dash/extensions/server/console.lua
        -- Author: dash
        local text = COLOR_CLEAR_SEQUENCE

        for k, v in ipairs( args ) do
            if istable( v ) and v.r and v.g and v.b then
                text = text..'\27[38;5;'..AMB.Ambition.Utility.Coding.RGBToAnsi256( v.r, v.g, v.b )..'m'
            else
                text = text..v
            end
        end

        _MsgC( text..COLOR_CLEAR_SEQUENCE )
    else
        MsgC( unpack( args ) )
    end
end

-------------------------------------------------------------------------------------------------------
local consolecmds = {}
function AMB.Ambition.AddConsoleCommand( sCommand, bOnlyServer, fCallback, fAutoComplete, sHelpText, nFlags )
    sCommand = sCommand or 'test'
    local cmd = bOnlyServer and 'amb_'..AMB.Config.prefix..'_'..sCommand or 'amb_'..sCommand

    consolecmds[ sCommand ] = { command = cmd, only_server = bOnlyServer, callback = fCallback, help = sHelpText, flags = nFlags }

    return concommand.Add( cmd, fCallback, fAutoComplete, sHelpText or 'Ambition' )
end

function AMB.Ambition.GetConsoleCommands()
    return consolecmds
end
AMB.Ambition.AddConsoleCommand( 'cmds', false, function() PrintTable( consolecmds ) end )

-------------------------------------------------------------------------------------------------------
local red, green, blue, yellow, white, gray = nil

local warnings = {}
function AMB.Ambition.Warning( sHeader, sMessage )
    if not red then
        local C = AMB.Ambition.Global.Colors

        red = C.AMB_ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMB_YELLOW
        white = C.ABS_WHITE
        gray = C.AMB_GRAY
    end

    sHeader = sHeader or 'Header'
    sMessage = sMessage or 'Text'

    local traceback = debug.traceback()
    local text = '[Warning] ['..sHeader..'] '..sMessage
    warnings[ #warnings + 1 ] = { message = text, time = os.date( '(%X)', os.time() ), traceback = traceback }

    MsgC( yellow, '\n-------------------------------------------------\n' )
    AMB.Ambition.Print( yellow, '[Warning] ', blue, '['..sHeader..'] ', white, '['..sMessage..']'..'\n\n' )
    MsgC( gray, traceback..'\n' )
    MsgC( yellow, '-------------------------------------------------\n' )
end

function AMB.Ambition.GetWarnings()
    return warnings
end
AMB.Ambition.AddConsoleCommand( 'warnings', false, function() PrintTable( warnings ) end )

local errors = {}
function AMB.Ambition.Error( sHeader, sMessage )
    if not red then
        local C = AMB.Ambition.Global.Colors

        red = C.AMB_ERROR
        green = C.FLAT_GREEN
        blue = C.FLAT_BLUE
        yellow = C.AMB_YELLOW
        white = C.ABS_WHITE
        gray = C.AMB_GRAY
    end

    sHeader = sHeader or 'Header'
    sMessage = sMessage or 'Text'

    local traceback = debug.traceback()
    local text = '[Error] ['..sHeader..'] '..sMessage
    errors[ #errors + 1 ] = { message = text, time = os.date( '(%X)', os.time() ), traceback = traceback }

    MsgC( red, '\n-------------------------------------------------\n' )
    AMB.Ambition.Print( red, '[Error] ', green, '['..sHeader..'] ', white, '['..sMessage..']'..'\n\n' )
    MsgC( gray, traceback..'\n' )
    MsgC( red, '-------------------------------------------------\n' )
end

function AMB.Ambition.GetErrors()
    return errors
end
AMB.Ambition.AddConsoleCommand( 'errors', false, function() PrintTable( errors ) end )

-------------------------------------------------------------------------------------------------------
function AMB.Ambition.Material( sHeader, sParam )
    return Material( 'ambition/'..sHeader, sParam )
end

function AMB.Ambition.Sound( sHeader )
    return 'ambition/'..sHeader
end