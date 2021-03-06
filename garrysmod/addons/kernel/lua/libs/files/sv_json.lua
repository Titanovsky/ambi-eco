AMB.Files.JSON = AMB.Files.JSON or {}

local util = util

function AMB.Files.JSON.In( tData, bPrint )

    bPrint = bPrint or false

    local data_str = util.TableToJSON( tData, bPrint )

    return data_str

end

function AMB.Files.JSON.Out( sJSON )

    local data_tab = util.JSONToTable( sJSON )

    return data_tab

end