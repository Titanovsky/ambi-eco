local C, GUI, Draw, UI, CL, Lang = Ambi.Packages.Out( '@d, ContentLoader, Language' )
local W, H = ScrW(), ScrH()
local COLOR_PANEL = Color( 0, 0, 0, 100 )
local COLOR_PANEL2 = Color( 0, 0, 0, 150 )
local configs = {}

-- ---------------------------------------------------------------------------------------------------------------------------------------
Lang.SimpleAdd( 'configurator_not_allowed', 'Нет доступа!', 'You don\'t have access!' )
Lang.SimpleAdd( 'configurator_successful_change', 'Вы изменили конфиг: ', 'You changed the config: ' )

-- ---------------------------------------------------------------------------------------------------------------------------------------
local function IsColor( tTab )
    if istable( tTab ) and tTab.r and tTab.g and tTab.b and not tTab.x then return true end
end

local function CheckAccess()
    return Ambi.Configurator.Config.allowed_ranks[ LocalPlayer():GetUserGroup() ]
end

local function SendToServerChangedConfig( sModule )
    if not CheckAccess() then return end
    
    local tab = {}
    for k, v in pairs( Ambi[ sModule ].Config ) do
        if isfunction( v ) or ismatrix( v ) or IsEntity( v ) then print( '[Configurator] not success type data: '..tostring( k )..' ('..sModule..')' ) continue end

        tab[ k ] = v
    end

    net.Start( 'ambi_configurator_change_table' )
        net.WriteString( sModule )
        net.WriteTable( tab )
    net.SendToServer()

    print( '[Configurator] You send changes for config '..sModule..' to server, wait...' )
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
function Ambi.Configurator.Open()
    if not CheckAccess() then
        local block = GUI.DrawFrame( nil, W / 4, H / 8, 0, 0, '', false, false, false, function( self, w, h ) 
            Draw.Box( w, h, 0, 0, C.RED )
            Draw.Box( w - 8, h - 8, 4, 4, C.AMBI_BLACK )

            Draw.SimpleText( w / 2, h / 2, Lang.Get( 'configurator_not_allowed' ), UI.SafeFont( '36 Ambi' ), C.ABS_WHITE, 'center', 1, C.ABS_BLACK )
        end )
        block:Center()

        timer.Simple( 4, function()
            if ValidPanel( block ) then block:Remove() end
        end )

        surface.PlaySound( 'Error' )

        MsgC( C.RED, '[Configurator] ', C.WHITE, 'you don\'t have access for change configs!\n' )

        return
    end

    for k, v in pairs( Ambi ) do
        if not istable( v ) or not v.Config then continue end

        configs[ k ] = v.Config
    end

    local header = 'Configurator '..Ambi.Configurator.Meta.VERSION

    local frame = GUI.DrawFrame( nil, W / 1.1, H / 1.1, 0, 0, '', true, true, true, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_BLACK )
        Draw.Box( w, 32, 0, 0, C.AMBI )

        Draw.SimpleText( 4, 4, header, UI.SafeFont( '22 Facile Sans' ), C.ABS_WHITE, 'top-left', 1, C.ABS_BLACK )

        if not CheckAccess() then 
            surface.PlaySound( 'Error' )
            self:Remove() 
            
            return 
        end
    end )
    frame:Center()

    local top = GUI.DrawScrollPanel( frame, frame:GetWide(), 32, 0, 32, function( self, w, h ) 
        Draw.Box( w, 4, 0, h - 4, C.AMBI ) -- bottom
        Draw.Box( 4, h, 0, 0, C.AMBI ) -- left
        Draw.Box( 4, h, w - 4, 0, C.AMBI ) -- right
    end )

    local panels = GUI.DrawScrollPanel( frame, frame:GetWide(), frame:GetTall() - top:GetTall() - 32, 0, 32 + top:GetTall(), function( self, w, h ) 
        -- Draw.Box( w, h, 0, 0, C.BLUE ) -- debug
    end )

    local pages = { { tab = configs, header = '' } }

    Ambi.Configurator.OpenTable( configs, panels, 1, pages )
end
concommand.Add( 'ambi_configurator', Ambi.Configurator.Open )

function Ambi.Configurator.OpenTable( tTable, vguiPanel, nCurrentPage, tPages, sModule )
    vguiPanel:Clear()

    if ( nCurrentPage == 1 ) then 
        sModule = nil
        tPages = { { tab = tTable, header = '' } }
    end -- the first page is always configs and it don't have forward page.
    
    local panels = GUI.DrawScrollPanel( vguiPanel, vguiPanel:GetWide(), vguiPanel:GetTall(), 0, 0, function( self, w, h ) 
        Draw.Box( w, h, 0, 0, C.AMBI_BLACK )

        if ( nCurrentPage > 1 ) then
            Draw.SimpleText( w / 2, 4, tPages[ nCurrentPage ].header, UI.SafeFont( '22 Ambi' ), C.ABS_WHITE, 'top-center', 1, C.BLACK )
        end
    end )

    local offset_y = 0

    if tPages and ( nCurrentPage > 1 ) then
        local back = GUI.DrawButton( panels, 32, 20, 4, 4, nil, nil, nil, function( self )
            local module = sModule or ( nCurrentPage == 1 ) and key or nil
            local page = nCurrentPage - 1
            Ambi.Configurator.OpenTable( tPages[ page ].tab, vguiPanel, page, tPages, module )
        end, function( self, w, h )
            Draw.SimpleText( w / 2, h / 2, '<<', UI.SafeFont( '18 Ambi' ), C.ABS_WHITE, 'center', 1, C.BLACK )
        end )

        offset_y = back:GetTall() + 8
    end

    if tPages and ( #tPages > 1 ) and ( nCurrentPage != #tPages ) then
        local forward = GUI.DrawButton( panels, 32, 20, panels:GetWide() - 32 - 4, 4, nil, nil, nil, function( self )
            local page = nCurrentPage + 1
            Ambi.Configurator.OpenTable( tPages[ page ].tab, vguiPanel, page, tPages, sModule )
        end, function( self, w, h )
            Draw.SimpleText( w / 2, h / 2, '>>', UI.SafeFont( '18 Ambi' ), C.ABS_WHITE, 'center', 1, C.BLACK )
        end )
    end

    local i = 0
    for key, value in pairs( tTable ) do
        local header_key = Ambi.Configurator.exceptions[ sModule ] and Ambi.Configurator.exceptions[ sModule ][ key ] or key

        local config = GUI.DrawButton( panels, panels:GetWide() - 4, 26, 2, offset_y + ( 26 + 2 ) * i + 4, nil, nil, nil, function( self )
            if istable( value ) then
                local page = nCurrentPage + 1
                tPages[ page ] = { tab = value, header = tPages[ nCurrentPage ].header..'/'..key }

                local module = sModule or ( nCurrentPage == 1 ) and key or nil
                Ambi.Configurator.OpenTable( value, vguiPanel, page, tPages, module )
            end
        end, function( self, w, h )
            Draw.Box( w, h, 0, 0, self.color_panel, 4 )

            Draw.SimpleText( 4, 4, header_key, UI.SafeFont( '22 Arial' ), ( istable( value ) and not IsColor( value ) ) and C.USA_SILVER or C.WHITE, 'top-left' )
        end )
        config:SetTooltip( tostring( key ) )
        config.color_panel = COLOR_PANEL
        GUI.OnCursor( config, function()
            config.color_panel = ColorAlpha( COLOR_PANEL, 160 )
        end, function() 
            config.color_panel = COLOR_PANEL
        end )

        if not istable( value ) or IsColor( value ) then
            config:SetCursor( 'arrow' )
            config:SetWide( panels:GetWide() / 1.6 )

            local attribute = GUI.DrawButton( panels, panels:GetWide() - config:GetWide() - 8, 26, 2 + config:GetWide() + 2, offset_y + ( 26 + 2 ) * i + 4, nil, nil, nil, function( self )
                if isnumber( value ) then
                    local entry = GUI.DrawTextEntry( self, self:GetWide(), self:GetTall(), 0, 0, '22 Arial', nil, '', C.AMBI_GRAY, tostring( value ), false, true )
                    entry.OnLoseFocus = function( self )
                        value = tonumber( self:GetValue() ) -- for this
                        tTable[ key ] = value -- for global table (config)
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                    entry.OnEnter = function( self, sValue )
                        value = tonumber( sValue ) -- for this
                        tTable[ key ] = value -- for global table (config)
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                elseif isstring( value ) then
                    local entry = GUI.DrawTextEntry( self, self:GetWide(), self:GetTall(), 0, 0, '22 Arial', nil, '', C.AMBI_GRAY, tostring( value ), false ) -- ? the last argument is "Multiline" bad works with Enter, how to fix
                    entry.OnLoseFocus = function( self )
                        value = self:GetValue() -- for this
                        tTable[ key ] = value -- for global table (config)
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                    entry.OnEnter = function( self, sValue )
                        value = sValue -- for this
                        tTable[ key ] = value -- for global table (config)
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                elseif isbool( value ) then
                    value = not value -- for this
                    tTable[ key ] = value -- for global table (config)

                    SendToServerChangedConfig( sModule )
                elseif IsColor( value ) then
                    local entry = GUI.DrawTextEntry( self, self:GetWide(), self:GetTall(), 0, 0, '22 Arial', nil, '', C.AMBI_GRAY, tostring( value ), false ) -- ? the last argument is "Multiline" bad works with Enter, how to fix
                    entry.OnLoseFocus = function( self )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Color( tonumber( tab_value[ 1 ] or 255 ), tonumber( tab_value[ 2 ] or 255 ), tonumber( tab_value[ 3 ] or 255 ), tonumber( tab_value[ 4 ] or 255 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                    entry.OnEnter = function( self, sValue )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Color( tonumber( tab_value[ 1 ] or 255 ), tonumber( tab_value[ 2 ] or 255 ), tonumber( tab_value[ 3 ] or 255 ), tonumber( tab_value[ 4 ] or 255 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                elseif IsVector( value ) then
                    local entry = GUI.DrawTextEntry( self, self:GetWide(), self:GetTall(), 0, 0, '22 Arial', nil, '', C.AMBI_GRAY, tostring( value ), false ) -- ? the last argument is "Multiline" bad works with Enter, how to fix
                    entry.OnLoseFocus = function( self )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Vector( tonumber( tab_value[ 1 ] or 0 ), tonumber( tab_value[ 2 ] or 0 ), tonumber( tab_value[ 3 ] or 0 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                    entry.OnEnter = function( self, sValue )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Vector( tonumber( tab_value[ 1 ] or 0 ), tonumber( tab_value[ 2 ] or 0 ), tonumber( tab_value[ 3 ] or 0 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                elseif IsAngle( value ) then
                    local entry = GUI.DrawTextEntry( self, self:GetWide(), self:GetTall(), 0, 0, '22 Arial', nil, '', C.AMBI_GRAY, tostring( value ), false ) -- ? the last argument is "Multiline" bad works with Enter, how to fix
                    entry.OnLoseFocus = function( self )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Angle( tonumber( tab_value[ 1 ] or 0 ), tonumber( tab_value[ 2 ] or 0 ), tonumber( tab_value[ 3 ] or 0 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                    entry.OnEnter = function( self, sValue )
                        local tab_value = string.Explode( ' ', self:GetValue() )
                        value = Angle( tonumber( tab_value[ 1 ] or 0 ), tonumber( tab_value[ 2 ] or 0 ), tonumber( tab_value[ 3 ] or 0 ) )

                        tTable[ key ] = value
                        self:Remove()

                        SendToServerChangedConfig( sModule )
                    end
                end
            end, function( self, w, h )
                Draw.Box( w, h, 0, 0, self.color_panel, 4 )
    
                Draw.SimpleText( IsColor( value ) and 32 or 4, 4, tostring( value ), UI.SafeFont( '22 Arial' ), Ambi.Configurator.GetColor( value ), 'top-left' )
            end )
            attribute:SetTooltip( tostring( value ) )
            attribute.color_panel = COLOR_PANEL2
            GUI.OnCursor( attribute, function()
                attribute.color_panel = ColorAlpha( C.WHITE, 10 )
            end, function() 
                attribute.color_panel = COLOR_PANEL2
            end )

            if IsColor( value ) then
                local check_box = GUI.DrawPanel( attribute, 24, attribute:GetTall() - 4, 2, 2, function( self, w, h ) 
                    Draw.Box( w, h, 0, 0, value, 4 )
                end )
            end
        end
       
        i = i + 1
    end
end

function Ambi.Configurator.GetColor( anyValue )
    if IsColor( anyValue ) then return C.WHITE -- color раньше, чем table из-за ебанутости
    elseif istable( anyValue ) then return C.AMBI
    elseif isstring( anyValue ) then return C.AMBI_SOFT_YELLOW
    elseif isnumber( anyValue ) then return C.AMBI_BLUE
    elseif isbool( anyValue ) then return anyValue and C.GREEN or C.RED
    elseif IsAngle( anyValue ) then return C.AU_GREEN
    elseif IsVector( anyValue ) then return C.AU_SOFT_RED
    else return C.AMBI_GRAY
    end
end

-- ---------------------------------------------------------------------------------------------------------------------------------------
net.Receive( 'ambi_configurator_send_changed_table_to_player', function() 
    local name_module = net.ReadString()
    local changed_table = net.ReadTable()

    for key, value in pairs( changed_table ) do
        if Ambi[ name_module ].Config[ key ] then Ambi[ name_module ].Config[ key ] = value end
    end

    print( '[Configurator] The config '..name_module..' has changed!' )
end )