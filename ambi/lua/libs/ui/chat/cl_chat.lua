Ambi.UI.Chat = Ambi.UI.Chat or {}

-- --------------------------------------------------------------------------------------------------------------------------------------
local C, Gen, Lang = Ambi.General.Global.Colors, Ambi.General, Ambi.General.Language
local chat, unpack, net, StartWith, EndsWith = chat, unpack, net, string.StartWith, string.EndsWith
local Explode, FindObsceneWords, ReplaceObsceneWords, Implode, Replace = string.Explode, string.FindObsceneWords, string.ReplaceObsceneWords, string.Implode, string.Replace
local string_gmatch, string_gsub, string_find, string_sub, string_Trim = string.gmatch, string.gsub, string.find, string.sub, string.Trim
local cached_colors = {}

local show_obscene_language = CreateClientConVar( 'ambi_show_obscene_language', 1 )

local PATTERN_FOR_LANGUAGE, PATTERN_COLOR = '#', '~'
local NUMBERS = { [ '0' ] = 0, [ '1' ] = 0, [ '2' ] = 0, [ '3' ] = 0, [ '4' ] = 0, [ '5' ] = 0, [ '6' ] = 0, [ '7' ] = 0, [ '8' ] = 0, [ '9' ] = 0, }

-- --------------------------------------------------------------------------------------------------------------------------------------
local function CalcColor( sColor )
    if cached_colors[ sColor ] then return cached_colors[ sColor ] end
    
    if NUMBERS[ sColor[ 1 ] ] then
        local rgb = string.Explode( ' ', sColor )
        local color = Color( tonumber( rgb[ 1 ] ), tonumber( rgb[ 2 ] ), tonumber( rgb[ 3 ] ) )

        cached_colors[ sColor ] = color

        return color
    end

    return C[ sColor ]
end

local function SplitTableByColors( tTab )
    local new_tab = {}
    local text = tTab[ 1 ]
    local colors = {}
    local strings = {}

    for v in string_gmatch( text, '~.-~' ) do
        colors[ #colors + 1 ] = v
    end

    if ( #colors > 0 ) then
        for i, color in ipairs( colors ) do
            local pos_start, pos_end, str = string_find( text, color )
            local color = CalcColor( string_sub( text, pos_start + 1, pos_end - 1 ) )
            text = string_sub( text, pos_end + 1, #text )
            local str = string_Trim( string_gsub( text, '~.*', '' ), ' ' ) .. ' '

            i = #new_tab + 1
            new_tab[ i ] = color
            new_tab[ i + 1 ] = str
        end

        return new_tab
    end

    return tTab
end

function Ambi.UI.Chat.Send( ... )
    local tab = { ... }

    if isstring( tab[ 1 ] ) then tab = SplitTableByColors( tab ) end

    for i = 1, #tab do
        local value = tab[ i ]

        if isstring( value ) then
            if StartWith( value, PATTERN_FOR_LANGUAGE ) then 
                local endpoint = ( i == #tab ) and '' or ' ' --! workaround for string_Trim, else without Trim the string is uncorrect
                tab[ i ] = Lang.Get( string_Trim( Replace( value, PATTERN_FOR_LANGUAGE, '' ) ) )..endpoint
            elseif StartWith( value, PATTERN_COLOR ) and EndsWith( value, PATTERN_COLOR ) then 
                tab[ i ] = C[ Replace( value, PATTERN_COLOR, '' ) ]
            end

            if not show_obscene_language:GetBool() then
                local _tab = Explode( ' ', value )
                for j = 1, #_tab do
                    local word = _tab[ j ]
                    if FindObsceneWords( word ) then _tab[ j ] = ReplaceObsceneWords( word ) end
                end

                tab[ i ] = Implode( ' ', _tab )
            end
        end
    end

    chat.AddText( unpack( tab ) )
    Ambi.UI.Chat.AddLog( tab )

    hook.Call( '[Ambi.UI.Chat.Send]', nil, tab )
end

-- -------------------------------------------------------------------------------------
local logs = {}

function Ambi.UI.Chat.AddLog( tInfo )
    tInfo.time = os.time()

    local id = #logs + 1
    logs[ id ] = tInfo

    hook.Call( '[Ambi.UI.Chat.AddedLog]', nil, logs[ id ] )
end

function Ambi.UI.Chat.GetLogs()
    return logs
end

-- -------------------------------------------------------------------------------------
net.Receive( 'ambi_ui_chat_send', function() 
    local tab = net.ReadTable()
    if not tab then return end

    Ambi.UI.Chat.Send( unpack( tab )  )
end )