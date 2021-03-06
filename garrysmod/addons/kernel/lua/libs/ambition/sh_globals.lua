AMB.G = AMB.G or {}

-- ## COLORS ###################

AMB.G.C = AMB.G.C or {}

local rgb = Color

AMB.G.C.ABS_RED     = rgb( 255, 0, 0 )
AMB.G.C.ABS_GREEN   = rgb( 0, 255, 0 )
AMB.G.C.ABS_BLUE    = rgb( 0, 0, 255 )
AMB.G.C.ABS_FROZEN  = rgb( 0, 255, 255 )
AMB.G.C.ABS_PURPLE  = rgb( 255, 0, 255 )
AMB.G.C.ABS_YELLOW  = rgb( 255, 255, 0 )
AMB.G.C.ABS_WHITE   = rgb( 255, 255, 255 )
AMB.G.C.ABS_BLACK   = rgb( 0, 0, 0 )

-- Ambition
AMB.G.C.AMBITION        = rgb( 230, 157, 41 )
AMB.G.C.AMB_ERROR       = rgb( 219, 72, 46 )
AMB.G.C.AMB_PANEL       = rgb( 0, 0, 0, 200 )
AMB.G.C.AMB_LOG         = rgb( 23, 207, 90 )
AMB.G.C.AMB_RED         = AMB.G.C.AMB_ERROR
AMB.G.C.AMB_BLOOD       = rgb( 150, 27, 11 )
AMB.G.C.AMB_GREEN       = rgb( 67, 184, 28 )
AMB.G.C.AMB_SALAT       = rgb( 63, 191, 114 )
AMB.G.C.AMB_BLUE        = rgb( 41, 118, 186 )
AMB.G.C.AMB_HARD_BLUE   = rgb( 43, 98, 207 )
AMB.G.C.AMB_SOFT_BLUE   = rgb( 57, 212, 209 )
AMB.G.C.AMB_ORANGE      = AMB.G.C.AMBITION
AMB.G.C.AMB_CARROT      = rgb( 217, 118, 33 )
AMB.G.C.AMB_YELLOW      = rgb( 222, 219, 42 )
AMB.G.C.AMB_SOFT_YELLOW = rgb( 255, 252, 97 )
AMB.G.C.AMB_DARK_YELLOW = rgb( 179, 176, 21 )
AMB.G.C.AMB_PURPLE      = rgb( 160, 39, 217 )
AMB.G.C.AMB_SOFT_PURPLE = rgb( 101, 46, 219 )
AMB.G.C.AMB_DARK_PURPLE = rgb( 123, 19, 168 )
AMB.G.C.AMB_ULTRA_GREEN = rgb( 46, 204, 113 )
AMB.G.C.AMB_DARK_BLACK  = rgb( 40, 40, 40 )
AMB.G.C.AMB_BLACK       = rgb( 56, 56, 56 )
AMB.G.C.AMB_WHITE       = rgb( 243, 243, 243 )
AMB.G.C.AMB_GRAY        = rgb( 173, 173, 173 )

-- https://flatuicolors.com/palette/defo
AMB.G.C.FLAT_RED            = rgb(231, 76, 60) -- alizarin
AMB.G.C.FLAT_DARK_RED       = rgb(192, 57, 43) -- pomegranate
AMB.G.C.FLAT_GREEN          = rgb(46, 204, 113) -- emerald
AMB.G.C.FLAT_DARK_GREEN     = rgb(39, 174, 96) -- nephritis
AMB.G.C.FLAT_BLUE           = rgb(52, 152, 219) -- peter river
AMB.G.C.FLAT_DARK_BLUE      = rgb(41, 128, 185) -- belize hole
AMB.G.C.FLAT_PURPLE         = rgb(155, 89, 182) -- amethyst
AMB.G.C.FLAT_DARK_PURPLE    = rgb(142, 68, 173) -- wisteria
AMB.G.C.FLAT_ORANGE         = rgb(243, 156, 18) -- orange
AMB.G.C.FLAT_DARK_ORANGE    = rgb(211, 84, 0) -- pumpking
AMB.G.C.FLAT_YELLOW         = rgb(241, 196, 15) -- sun flower
AMB.G.C.FLAT_WHITE          = rgb(236, 240, 241) -- clouds
AMB.G.C.FLAT_GRAY           = rgb(149, 165, 166) -- concrete
AMB.G.C.FLAT_SILVER         = rgb(189, 195, 199) -- silver

-- https://flatuicolors.com/palette/ru
AMB.G.C.RU_RED    = rgb(225, 95, 65) -- tigerlily
AMB.G.C.RU_PINK   = rgb(248, 165, 194) -- rogue pink
AMB.G.C.RU_BLUE   = rgb(99, 205, 218) -- squeaky

-- ## ENT ######################

AMB.G.CATEGORIES = AMB.G.CATEGORIES or {}

AMB.G.AUTHOR    = 'Ambition'
AMB.G.RENDER    = RENDERGROUP_BOTH

function AMB.G.Category( sName )

    for id, name in ipairs( AMB.G.CATEGORIES ) do

        if ( name == sName ) then return id..'. '..name end

    end

    local ID = #AMB.G.CATEGORIES + 1

    AMB.G.CATEGORIES[ ID  ] = sName

    return ID..'. '..sName

end

-- ## Sounds ###################

AMB.G.SND = AMB.G.SND or {}

AMB.G.SND.ERROR = 'buttons/button10.wav' 
AMB.G.SND.RELEASE_BUTTON = 'UI/buttonrollover.wav' 

-- #############################

function AMB.G.GetTable()

    return AMB.G

end

function AMB.G.PrintTable()

    PrintTable( AMB.G )

end

function AMB.G.PrintColors()

    PrintTable( AMB.G.C )

end

function AMB.G.GetError( sModule, sIndex )

    return sModule..' | Connect Failed | ERROR_TCL #'..sIndex

end