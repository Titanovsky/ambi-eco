AMB.Logs = AMB.Logs or {}
AMB.Logs.Tables = AMB.Logs.Tables or {}

local MsgC = MsgC

function AMB.Logs.Print( sColorModule, sHeader, sText )

    if ( AMB.Config.log_flag == 0 ) then return end

    sColorModule = sColorModule or AMB.G.C.AMB_LOG
    sHeader = sHeader or 'MODULE'
    sText = sText or ''

    MsgC( sColorModule, '['..sHeader..'] ', AMB.G.C.ABS_WHITE, sText, sColorModule, os.date( ' [%X]\n', os.time() ) )

end

