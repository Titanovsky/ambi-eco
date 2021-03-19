AMB.UI.MainMenu.Pages = AMB.UI.MainMenu.Pages or {}

local CFG = AMB.UI.MainMenu.Config
local C = AMB.G.C
local SND = AMB.G.SND
local CMD = 'amb_mm_'..AMB.Config.prefix

local w = ScrW()
local h = ScrH()

local Cvar = GetConVar
local CvarBool = function( sCvar ) return Cvar( CMD..'_'..sCvar ):GetBool() end

local current_page_id = 0
local current_pages = {} -- для того, чтобы у тех, кто поставил multi на 1, загружали сохранёные страницы
local pages = {}

function AMB.UI.MainMenu.Pages.GetPage( nPage )

    return AMB.UI.MainMenu.Config.pages[ nPage ] or false

end

function AMB.UI.MainMenu.Pages.AddPage( nPage, sName, cColorText, fDraw )

    if ( nPage <= 0 ) or ( nPage > 8 ) then AMB.ErrorLog( 'UI.MainMenu.Pages', 'ID Page can to be from 1 to 8' ) return false end

    sName = string.upper( sName ) or nPage
    cColorText = cColorText or C.AMB_WHITE
    fDraw = fDraw or function( vguiFrame ) end

    AMB.UI.MainMenu.Config.pages[ nPage ] = nil

    AMB.UI.MainMenu.Config.pages[ nPage ] = {

        name = sName,
        color = cColorText or C.AMB_WHITE,
        draw = fDraw

    }

    return nPage

end

function AMB.UI.MainMenu.Pages.SetPage( nPage, fDraw )

    local page = AMB.UI.MainMenu.Config.pages[ nPage ]

    if not page then AMB.ErrorLog( 'UI.MainMenu.Pages', 'Page ID '..nPage..' not valid' ) return end

   page.draw = fDraw

   return nPage

end

function AMB.UI.MainMenu.Pages.RemovePage( nPage )

    AMB.UI.MainMenu.Config.pages[ nPage ] = nil

    return true

end

function AMB.UI.MainMenu.Pages.BackSavePages( vguiFrame )

    if not CvarBool( 'page_multi' ) and ( current_page_id > 0 ) then AMB.UI.MainMenu.Pages.OpenPage( current_page_id, vguiFrame ) return end

    if not pages then return end

    for id, page in pairs( pages ) do

        if page then AMB.UI.MainMenu.Pages.OpenPage( id, vguiFrame ) end

    end

end

function AMB.UI.MainMenu.Pages.OpenPage( nPage, vguiFrame )

    local page = AMB.UI.MainMenu.Config.pages[ nPage ]

    if not page then return end

    if current_pages[ nPage ] and CvarBool( 'page_multi' ) then return end -- это только для многостраничников
    
    current_page_id = nPage
    current_pages[ nPage ] = true
    
    if not CvarBool( 'page_multi' ) then 
    
        if ValidPanel( vguiFrame ) then vguiFrame:Clear() end
        AMB.UI.MainMenu.Pages.ClearPages() 
        
    else 
    
        pages[ nPage ] = page 
    
    end

    page.draw( vguiFrame )

    return nPage

end

function AMB.UI.MainMenu.Pages.ClosePage( nPage, vguiFrame )

    local page = AMB.UI.MainMenu.Config.pages[ nPage ]

    if not page then print('sda') return end
    if not ValidPanel( vguiFrame ) then print('asd') return end

    current_pages[ nPage ] = false
    pages[ nPage ] = false

    if ( nPage == current_page_id ) then current_page_id = 0 end -- удаляет одиночную страничку

end

function AMB.UI.MainMenu.Pages.ClearPage( nPage )

    pages[ nPage ] = nil

end

function AMB.UI.MainMenu.Pages.ClearPages()

    pages = {}

end
concommand.Add( 'amb_mm_clean', AMB.UI.MainMenu.Pages.ClearPages )

function AMB.UI.MainMenu.Pages.ClearCurrentPages()

    current_pages = {}

end