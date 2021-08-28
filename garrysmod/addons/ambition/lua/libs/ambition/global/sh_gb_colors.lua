AMB.Ambition.Global = AMB.Ambition.Global or {}

-- • Я у кого-то слышал, что Color() записанный HEX числами быстрее, чем с десятичными

-- -------------------------------------------------------------------------------------
local rgb = Color
-- -------------------------------------------------------------------------------------

AMB.Ambition.Global.Colors = AMB.Ambition.Global.Colors or {
    -- Absolutly
    ABS_RED     = rgb( 255, 0, 0 ),
    ABS_GREEN   = rgb( 0, 255, 0 ),
    ABS_BLUE    = rgb( 0, 0, 255 ),
    ABS_FROZEN  = rgb( 0, 255, 255 ),
    ABS_PURPLE  = rgb( 255, 0, 255 ),
    ABS_YELLOW  = rgb( 255, 255, 0 ),
    ABS_WHITE   = rgb( 255, 255, 255 ),
    ABS_BLACK   = rgb( 0, 0, 0 ),

    -- Ambition
    AMBITION        = rgb( 230, 157, 41 ),
    AMB_ERROR       = rgb( 219, 72, 46 ),
    AMB_PANEL       = rgb( 0, 0, 0, 200 ),
    AMB_LOG         = rgb( 23, 207, 90 ),
    AMB_RED         = rgb( 219, 72, 46 ),
    AMB_BLOOD       = rgb( 150, 27, 11 ),
    AMB_GREEN       = rgb( 67, 184, 28 ),
    AMB_SALAT       = rgb( 63, 191, 114 ),
    AMB_BLUE        = rgb( 41, 118, 186 ),
    AMB_HARD_BLUE   = rgb( 43, 98, 207 ),
    AMB_SOFT_BLUE   = rgb( 57, 212, 209 ),
    AMB_ORANGE      = rgb( 230, 157, 41 ),
    AMB_CARROT      = rgb( 217, 118, 33 ),
    AMB_YELLOW      = rgb( 222, 219, 42 ),
    AMB_SOFT_YELLOW = rgb( 255, 252, 97 ),
    AMB_DARK_YELLOW = rgb( 179, 176, 21 ),
    AMB_PURPLE      = rgb( 160, 39, 217 ),
    AMB_SOFT_PURPLE = rgb( 101, 46, 219 ),
    AMB_DARK_PURPLE = rgb( 123, 19, 168 ),
    AMB_ULTRA_GREEN = rgb( 46, 204, 113 ),
    AMB_DARK_BLACK  = rgb( 40, 40, 40 ),
    AMB_BLACK       = rgb( 56, 56, 56 ),
    AMB_WHITE       = rgb( 230, 230, 230 ),
    AMB_GRAY        = rgb( 173, 173, 173 ),

    -- https://flatuicolors.com/palette/defo
    FLAT_RED        = rgb(231, 76, 60), -- alizarin
    FLAT_DARK_RED   = rgb(192, 57, 43), -- pomegranate
    FLAT_GREEN      = rgb(46, 204, 113), -- emerald
    FLAT_DARK_GREEN = rgb(39, 174, 96), -- nephritis
    FLAT_BLUE       = rgb(52, 152, 219), -- peter river
    FLAT_DARK_BLUE  = rgb(41, 128, 185), -- belize hole
    FLAT_PURPLE     = rgb(155, 89, 182), -- amethyst
    FLAT_ORANGE     = rgb(243, 156, 18), -- orange
    FLAT_YELLOW     = rgb(241, 196, 15), -- sun flower
    FLAT_WHITE      = rgb(236, 240, 241), -- clouds
    FLAT_GRAY       = rgb(149, 165, 166), -- concrete
    FLAT_SILVER     = rgb(189, 195, 199), -- silver
    FLAT_DARK_ORANGE = rgb(211, 84, 0), -- pumpking
    FLAT_DARK_PURPLE = rgb(142, 68, 173), -- wisteria

    -- https://flatuicolors.com/palette/ru
    RU_RED  = rgb(225, 95, 65), -- tigerlily
    RU_PINK = rgb(248, 165, 194), -- rogue pink
    RU_BLUE = rgb(99, 205, 218), -- squeaky
}

for i = 0, 255 do
    AMB.Ambition.Global.Colors[ 'PANEL_'..i ] = rgb( 0, 0, 0, i )
end