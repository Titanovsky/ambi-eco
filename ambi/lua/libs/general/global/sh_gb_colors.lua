Ambi.General.Global = Ambi.General.Global or {}

-- -------------------------------------------------------------------------------------
local Color = function( nRed, nGreen, nBlue, nAlpha ) return { r = nRed, g = nGreen, b = nBlue, a = nAlpha or 255 } end
local C_DEFAULT = Color( 0x0, 0x0, 0x0 )

-- -------------------------------------------------------------------------------------
Ambi.General.Global.Colors = Ambi.General.Global.Colors or {
    -- Absolutly
    ABS_RED     = Color( 255, 0, 0 ),
    ABS_GREEN   = Color( 0, 255, 0 ),
    ABS_BLUE    = Color( 0, 0, 255 ),
    ABS_FROZEN  = Color( 0, 255, 255 ),
    ABS_PURPLE  = Color( 255, 0, 255 ),
    ABS_YELLOW  = Color( 255, 255, 0 ),
    ABS_WHITE   = Color( 255, 255, 255 ),
    ABS_BLACK   = Color( 0, 0, 0 ),

    -- Ambi
    AMBI             = Color( 230, 157, 41 ),
    ERROR            = Color( 219, 72, 46 ),
    LOG              = Color( 23, 207, 90 ),
    PANEL            = Color( 0, 0, 0, 200 ),
    AMBI_RED         = Color( 219, 72, 46 ),
    AMBI_BLOOD       = Color( 150, 27, 11 ),
    AMBI_GREEN       = Color( 67, 184, 28 ),
    AMBI_SALAT       = Color( 63, 191, 114 ),
    AMBI_BLUE        = Color( 0, 145, 255 ),
    AMBI_HARD_BLUE   = Color( 43, 98, 207 ),
    AMBI_SOFT_BLUE   = Color( 57, 212, 209 ),
    AMBI_ORANGE      = Color( 230, 157, 41 ),
    AMBI_CARROT      = Color( 217, 118, 33 ),
    AMBI_YELLOW      = Color( 222, 219, 42 ),
    AMBI_SOFT_YELLOW = Color( 255, 252, 97 ),
    AMBI_DARK_YELLOW = Color( 179, 176, 21 ),
    AMBI_PURPLE      = Color( 160, 39, 217 ),
    AMBI_SOFT_PURPLE = Color( 101, 46, 219 ),
    AMBI_DARK_PURPLE = Color( 123, 19, 168 ),
    AMBI_ULTRA_GREEN = Color( 46, 204, 113 ),
    AMBI_DARK_BLACK  = Color( 42, 42, 42 ),
    AMBI_BLACK       = Color( 56, 56, 56 ),
    AMBI_WHITE       = Color( 230, 230, 230 ),
    AMBI_GRAY        = Color( 173, 173, 173 ),

    -- Shortcut
    WHITE = Color( 255, 255, 255),
    BLACK = Color( 0, 0, 0),
    RED = Color( 219, 72, 46 ),
    GREEN = Color( 67, 184, 28 ),
    BLUE = Color( 0, 145, 255 ),
    PURPLE = Color( 160, 39, 217 ),
    YELLOW = Color( 255, 252, 97 ),

    W = Color( 255, 255, 255),
    B = Color( 0, 0, 0),
    R = Color( 219, 72, 46 ),
    G = Color( 67, 184, 28 ),
    B = Color( 0, 145, 255 ),
    P = Color( 160, 39, 217 ),
    Y = Color( 255, 252, 97 ),

    -- https://flatuicolors.com/palette/defo
    FLAT_RED            = Color( 231, 76, 60 ), -- alizarin
    FLAT_DARK_RED       = Color( 192, 57, 43 ), -- pomegranate
    FLAT_GREEN          = Color( 46, 204, 113 ), -- emerald
    FLAT_DARK_GREEN     = Color( 39, 174, 96 ), -- nephritis
    FLAT_BLUE           = Color( 52, 152, 219 ), -- peter river
    FLAT_DARK_BLUE      = Color( 41, 128, 185 ), -- belize hole
    FLAT_PURPLE         = Color( 155, 89, 182 ), -- amethyst
    FLAT_ORANGE         = Color( 243, 156, 18 ), -- orange
    FLAT_YELLOW         = Color( 241, 196, 15 ), -- sun flower
    FLAT_WHITE          = Color( 236, 240, 241 ), -- clouds
    FLAT_GRAY           = Color( 149, 165, 166 ), -- concrete
    FLAT_SILVER         = Color( 189, 195, 199 ), -- silver
    FLAT_DARK_ORANGE    = Color( 211, 84, 0 ), -- pumpking
    FLAT_DARK_PURPLE    = Color( 142, 68, 173 ), -- wisteria

    -- https://flatuicolors.com/palette/ru
    RU_RED          = Color( 225, 95, 65 ), -- Tigerlily
    RU_PINK         = Color( 248, 165, 194 ), -- Rogue Pink
    RU_BLUE         = Color(84, 109, 229 ), -- Squeaky
    RU_SOFT_BLUE    = Color(119, 139, 235 ), -- Soft Blue
    RU_PURPLE       = Color(87, 75, 144 ), -- Purple Corallite
    RU_SOFT_PURPLE  = Color(120, 111, 166 ), -- Purple Mountain Majesty
    RU_PEACH        = Color(243, 166, 131 ), -- Creamy Peach
    RU_ORANGE       = Color(241, 144, 102 ), -- Sawtooth Aak
    RU_DARK         = Color(48, 57, 82 ), -- Biscay
    RU_GRAY         = Color(89, 98, 117 ), -- Pencil Lead

    -- https://flatuicolors.com/palette/us
    USA_RED         = Color(214, 48, 49), -- Chu-Gong
    USA_SOFT_RED    = Color(225, 112, 85), -- Orangeville
    USA_GREEN       = Color(0, 184, 148), -- Mint Leaf
    USA_SOFT_GREEN  = Color(85, 239, 196), -- Light Greenish Blue
    USA_BLUE        = Color(9, 132, 227), -- Electron Blue
    USA_SOFT_BLUE   = Color(116, 185, 255), -- Green Darner Tail
    USA_PINK        = Color(253, 121, 168), -- Pico-8 Pink
    USA_SOFT_SILVER = Color(223, 230, 233), -- City Lights
    USA_SILVER      = Color(178, 190, 195), -- Soothing Breeze
    USA_GRAY        = Color(99, 110, 114), -- American River
    USA_BLACK       = Color(45, 52, 54), -- Dracula Orchid

    -- https://flatuicolors.com/palette/gb
    UK_WHITE = Color(245, 246, 250),
    UK_GRAY = Color(113, 128, 147),
    UK_BLUE = Color(0, 168, 255),
    UK_SOFT_BLUE = Color(0, 151, 230),
    UK_RED = Color(232, 65, 24),
    UK_BLOOD = Color(194, 54, 22),
    UK_GREEN = Color(76, 209, 55),
    UK_DARK_GREEN = Color(68, 189, 50),
    UK_PURPLE = Color(156, 136, 255),
    UK_DARK_PURPLE = Color(140, 122, 230),
    UK_YELLOW = Color(251, 197, 49),
    UK_GOLD = Color(225, 177, 44),
    UK_BLACK = Color(47, 54, 64),

    -- https://flatuicolors.com/palette/au
    AU_GREY = Color(83, 92, 104),
    AU_SILVER = Color(149, 175, 192),
    AU_SNOW = Color(223, 249, 251),
    AU_DEEP_COVE = Color(19, 15, 64),
    AU_DEEP_KOAMARU = Color(48, 51, 107),
    AU_GREEN = Color(106, 176, 76),
    AU_SOFT_GREEN = Color(186, 220, 88),
    AU_RED = Color(235, 77, 75),
    AU_SOFT_RED = Color(255, 121, 121),
    AU_PURPLE = Color(190, 46, 221),
    AU_SOFT_PURPLE = Color(224, 86, 253),
    AU_ORANGE = Color(240, 147, 43),
    AU_SOFT_ORANGE = Color(255, 190, 118),
    AU_YELLOW = Color(249, 202, 36),
    AU_SOFT_YELLOW = Color(246, 229, 141),
    AU_BLURPLE = Color(72, 52, 212),
    AU_EXODUS_FRUIT = Color(104, 109, 224),

    -- https://gitlab.com/DBotThePony/DLib/-/blob/develop/lua_src/dlib/util/message.lua
    DLIB_DEFAULT_TEXT   = Color( 200, 200, 200 ),
    DLIB_WARNING        = Color( 239, 215, 52 ),
    DLIB_ERROR          = Color( 239, 78, 52 ),
    DLIB_BOOLEAN        = Color( 69, 112, 235 ),
    DLIB_NUMBER         = Color( 245, 199, 64 ),
    DLIB_STEAMID        = Color( 255, 255, 255 ),
    DLIB_ENTITY         = Color( 180, 232, 180 ),
    DLIB_NPC            = Color( 116, 193, 209 ),
    DLIB_NEXTBOT        = Color( 84, 196, 121 ),
    DLIB_WEAPON         = Color( 189, 82, 122 ),
    DLIB_VEHICLE        = Color( 189, 82, 170 ),
    DLIB_FUNCTION       = Color( 102, 133, 237 ),
    DLIB_TABLE          = Color( 107, 200, 224 ),
    DLIB_URL            = Color( 174, 124, 192 ),
    DLIB_NIL            = Color( 89, 93, 251 ),
    DLIB_COMMENTARY     = Color( 89, 93, 251 ),
}

setmetatable( Ambi.General.Global.Colors, { __index = function() return C_DEFAULT end } )