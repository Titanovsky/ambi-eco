AMB.UI.MainMenu = AMB.UI.MainMenu or {}
AMB.UI.MainMenu.Config = AMB.UI.MainMenu.Config or {}
AMB.UI.MainMenu.Pages = AMB.UI.MainMenu.Pages or {}
AMB.UI.MainMenu.Pages.list = AMB.UI.MainMenu.Pages.list or {}

CreateClientConVar( 'amb_menu_page', '1', true )

local w = ScrW()
local h = ScrH()

local cfg = AMB.UI.MainMenu.Config
local C = AMB.G.C

local choice_page = GetConVar( 'amb_menu_page' ):GetInt()
local choice_page_text = cfg.text_error

cfg.debug = false
cfg.wide = 800
cfg.tall = 600
cfg.color_pages = Color( 40, 40, 40 ) 
cfg.main_color = cfg.debug and C.AMB_WHITE or C.AMB_BLACK
cfg.text_error = 'Страница не найдена :3'

local function SetColorChoicePage( nPage )

    if ( choice_page ~= nPage ) then return false end

    return AMB.UI.MainMenu.Pages.list[ nPage ].color_background

end

local function BindKeyChoice( nPage )

    if ( nPage < 1 ) then return #AMB.UI.MainMenu.Pages.list end
    if ( nPage > #AMB.UI.MainMenu.Pages.list ) then return 1 end

    return nPage

end

function AMB.UI.MainMenu.CallMenu( nPage )

    local background    = AMB.UI.GUI.DrawPanel( nil, w, h, 0, 0, function( self, w, h ) AMB.UI.DrawBlur( self, 1 ) end )
    amb_mm              = AMB.UI.GUI.DrawFrame( nil, cfg.wide, cfg.tall, w/2-cfg.wide/2, h/2-cfg.tall/2, '', true, false, false, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, cfg.main_color  ) end )
    amb_mm.background   = background

    amb_mm:SetAlpha( 0 )
    amb_mm.background:SetAlpha( 0 )

    amb_mm.background:AlphaTo( 255, 0.55, 0, function() end )
    amb_mm:AlphaTo( 255, 0.15, 0, function() end )

    local logo = AMB.UI.GUI.DrawPanel( amb_mm, 200, 56, 0, 0, function( self, w, h ) 
    
        draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK )
        draw.SimpleText( 'A M B I T I O N', '32 Oswald Light', w/2, h/2, self.color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        
    end )
    logo.color = C.AMBITION

    local logo_button = AMB.UI.GUI.DrawButton( logo, logo:GetWide()-32, logo:GetTall()-16, 16, 8, nil, nil, nil, function() gui.OpenURL( 'https://steamcommunity.com/groups/ambitiongmod' ) end, function() end )
    logo_button.OnCursorEntered = function( self )

        self:GetParent().color = C.ABS_WHITE

    end
    logo_button.OnCursorExited = function( self )

        self:GetParent().color = C.AMBITION

    end

    local side_bar = AMB.UI.GUI.DrawPanel( amb_mm, amb_mm:GetWide()/4, amb_mm:GetTall()-56, 0, 56, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK ) end )
    local panel_divided_side = AMB.UI.GUI.DrawPanel( amb_mm, 4, amb_mm:GetTall(), amb_mm:GetWide()/4, 0, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMBITION ) end )

    local main_panel = AMB.UI.GUI.DrawPanel( amb_mm, amb_mm:GetWide()-204, amb_mm:GetTall(), amb_mm:GetWide()/4+4, 0, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, C.AMB_BLACK ) end )
    local pages_panel = AMB.UI.GUI.DrawPanel( main_panel, main_panel:GetWide()-12, main_panel:GetTall()-12, 6, 6, function( self, w, h ) end )

    local pages = AMB.UI.GUI.DrawGrid( side_bar, 200, 54, 0, 4, 1 )
    for k, v in pairs( AMB.UI.MainMenu.Pages.list ) do
        
        local p = 6
        local page = AMB.UI.GUI.DrawPanel( nil, pages:GetColWide()-4, pages:GetRowHeight()-4, 0, 0, function( self, w, h ) 
        
            draw.RoundedBox( 0, 0, 0, w, h, SetColorChoicePage( k ) or cfg.color_pages ) 
            
        end )
        pages:AddItem( page )

        local side_bar_page = AMB.UI.GUI.DrawPanel( page, 6, page:GetTall(), 0, 0, function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, v.color_side ) end ) 
        local button_page = AMB.UI.GUI.DrawButton( page, page:GetWide(), page:GetTall(), 0, 0, '20 Ambition', v.color_text, v.name, function( self )

            AMB.UI.MainMenu.Pages.ChoicePage( k, pages_panel )

        end, function( self, w, h ) end )
        button_page.OnCursorEntered = function( self )

            self:SetFont( '22 Ambition' )
            side_bar_page:SizeTo( 14, page:GetTall(), 0.25, 0, -1, function() end )

        end
        button_page.OnCursorExited = function( self )

            self:SetFont( '20 Ambition' )
            side_bar_page:SizeTo( 6, page:GetTall(), 0.25, 0, -1, function() end )

    	end

    end

    amb_mm.OnKeyCodePressed = function( self, nKey )
    
        if ( nKey == KEY_TAB ) then AMB.UI.MainMenu.RemoveMenu() end
        -- !!! DANGER KEY_W AND KEY_S WITH KEYINPUT PANEL !!!
        if ( nKey == KEY_UP ) or ( nKey == KEY_W ) then AMB.UI.MainMenu.Pages.ChoicePage( BindKeyChoice( choice_page-1 ), pages_panel ) end
        if ( nKey == KEY_DOWN ) or ( nKey == KEY_S ) then AMB.UI.MainMenu.Pages.ChoicePage( BindKeyChoice( choice_page+1 ), pages_panel ) end

    end

    AMB.UI.MainMenu.Pages.ChoicePage( GetConVar( 'amb_menu_page' ):GetInt(), pages_panel )

end

function AMB.UI.MainMenu.RemoveMenu()

    if ValidPanel( amb_mm ) then 
    
        amb_mm.background:Remove()
        amb_mm:Remove()
        choice_page_text = cfg.text_error
        choice_page = 0
        
    end

end

hook.Add( 'ScoreboardShow', 'CallMainMenu', function() AMB.UI.MainMenu.CallMenu() return false end )
hook.Add( 'ScoreboardHide', 'HideMainMenu', function() return false end )

-- # Controller Pages

function AMB.UI.MainMenu.Pages.AddPage( nPage, sName, cColorSide, cColorBackground, cColorText )

    AMB.UI.MainMenu.Pages.list[ nPage ] = nil

    AMB.UI.MainMenu.Pages.list[ nPage ] = {

        name = string.upper( sName ) or 'NaN',
        color_side = cColorSide or C.AMB_WHITE,
        color_background = ColorAlpha( cColorBackground, 80 ) or ColorAlpha( C.FLAT_WHITE, 80 ),
        color_text = cColorText or C.AMB_WHITE,
        func = function( vguiFrame ) end

    }

    return nPage

end

function AMB.UI.MainMenu.Pages.SetPage( nPage, fDrawVGUI )

    --PrintTable( AMB.UI.MainMenu.Pages.list[nPage] )
    AMB.UI.MainMenu.Pages.list[ nPage ].func = fDrawVGUI

end

function AMB.UI.MainMenu.Pages.SetSideColorPage( nPage, cColor )

    if AMB.UI.MainMenu.Pages.list[ nPage ] then AMB.UI.MainMenu.Pages.list[ nPage ].color_side = cColor return true end

end

function AMB.UI.MainMenu.Pages.SetBackgroundColorPage( nPage, cColor )

    if AMB.UI.MainMenu.Pages.list[ nPage ] then AMB.UI.MainMenu.Pages.list[ nPage ].color_background = cColor return true end

end

function AMB.UI.MainMenu.Pages.SetTextColorPage( nPage, cColor )

    if AMB.UI.MainMenu.Pages.list[ nPage ] then AMB.UI.MainMenu.Pages.list[ nPage ].color_text = cColor return true end

end

function AMB.UI.MainMenu.Pages.SetNamePage( nPage, sName )

    if AMB.UI.MainMenu.Pages.list[ nPage ] then AMB.UI.MainMenu.Pages.list[ nPage ].name = sName return true end

end

function AMB.UI.MainMenu.Pages.ChoicePage( nPage, vguiFrame )

    local page = AMB.UI.MainMenu.Pages.list[ nPage ]

    if ValidPanel( vguiFrame ) then vguiFrame:Clear() end

    if not page then return end
    
    choice_page = nPage
    choice_page_text = page.name

    page.func( vguiFrame )

end
