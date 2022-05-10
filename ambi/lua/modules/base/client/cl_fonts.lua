local Add = Ambi.UI.Font.AddStandart

for i = 1, Ambi.Base.Config.fonts_max_size do
    Add( 'Ambi', 'Usual', 'Roboto', i, 100, false )
    Add( 'Ambi Bold', 'Usual', 'Roboto', i, 600, false )

    Add( 'Arial', 'Usual', 'Arial', i, 100, false )
    Add( 'Arial Bold', 'Usual', 'Arial', i, 600, false )

    --Add( 'Franklin Gothic Demi', 'Usual', 'Franklin Gothic Demi', i, 13, true )

    Add( 'Oswald Light', 'Thin', 'Oswald Light', i, 100, true )
    Add( 'Oswald ExtraLight', 'Thin', 'Oswald ExtraLight', i, 100, true )

    Add( 'Alcotton', 'Usual', 'Alcotton', i, 500, true )
    Add( 'Arimo', 'Usual', 'Arimo', i, 500, true )
    Add( 'Yahfie', 'Usual', 'Yahfie', i, 500, true )
    Add( 'Gorga Grotesque', 'Usual', 'Gorga Grotesque', i, 500, true )
    Add( 'Bernier Shade', 'Usual', 'BERNIER Shade', i, 500, true )
    Add( 'DopegstyleG', 'Usual', 'mr_DopestyleG', i, 500, true )
    Add( 'Nexa Script Light', 'Usual', 'Nexa Script Light', i, 500, true )
    Add( 'Slimamif Medium', 'Usual', 'SlimamifMedium', i, 500, true )
    Add( 'Open Sans Condensed', 'Usual', 'Open Sans Condensed Light', i, 500, true )
    Add( 'Street Soul Cyrillic', 'Usual', 'Street Soul Cyrillic', i, 500, true )
    Add( 'Thintel', 'Usual', 'Thintel', i, 500, true )
    Add( 'Franxurter Totally Fat', 'Usual', 'Franxurter Totally Fat', i, 500, true )
end