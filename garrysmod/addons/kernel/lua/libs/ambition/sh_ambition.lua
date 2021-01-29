local print = print
local MsgC = MsgC
local tostring = tostring
local os = os

function AMB.SetConfig( sKey, anyValue )

    local old_value = AMB.Config[ sKey ]

    AMB.Config[ sKey ] = anyValue

    AMB.Logs.Print( 'Config '..sKey..' change value '..tostring( old_value )..' --> '..tostring( anyValue ) )

end

function AMB.Debug( fAction )

    if ( AMB.Config.dev == false ) then return end

    fAction()

end

AMB.console_logs = AMB.console_logs or {}

function AMB.ConsoleLog( sHeader, sText )

    if ( AMB.Config.logs == false ) then return end

    sHeader = sHeader or '*'
    sText = sText or 'Something'

    AMB.console_logs[ #AMB.console_logs+1 ] = { type = 'ConsoleLog', text = sHeader..' | '..sText, date = os.date( '%c', os.time() ) }

    MsgC( AMB.G.C.AMB_LOG, '## [LOG]', AMB.G.C.AMB_GRAY, ' | '..sHeader..' | ', AMB.G.C.AMB_WHITE, sText, AMB.G.C.AMB_LOG, ' \t##\n' )

end

function AMB.WarningLog( sHeader, sText )

    sHeader = sHeader or '*'
    sText = sText or 'Something'

    AMB.console_logs[ #AMB.console_logs+1 ] = { type = 'Warning', text = sHeader..' | '..sText, date = os.date( '%c', os.time() ) }

    MsgC( AMB.G.C.AMB_SOFT_YELLOW, '## [WARNING]', AMB.G.C.AMB_GRAY, ' | '..sHeader..' | ', AMB.G.C.AMB_WHITE, sText, AMB.G.C.AMB_SOFT_YELLOW, ' \t##\n' )

end

function AMB.ErrorLog( sHeader, sText )

    sHeader = sHeader or '*'
    sText = sText or 'Something'

    AMB.console_logs[ #AMB.console_logs+1 ] = { type = 'Error', text = sHeader..' | '..sText, date = os.date( '%c', os.time() ) }

    MsgC( AMB.G.C.AMB_ERROR, '## [ERROR]', AMB.G.C.AMB_GRAY, ' | '..sHeader..' | ', AMB.G.C.AMB_WHITE, sText..'!', AMB.G.C.AMB_ERROR, ' \t##\n' )

end