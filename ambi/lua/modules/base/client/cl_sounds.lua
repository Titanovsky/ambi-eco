local SND, Add = Ambi.General.Global.Sounds, Ambi.UI.Sound.Add

----------------------------------------------------------------------
Add( 'Error', SND.ERROR )

----------------------------------------------------------------------
Add( 'ButtonClick', 'UI/buttonclick.wav' )
Add( 'ButtonRelease', 'UI/buttonclickrelease.wav' )
Add( 'ButtonRollOver', 'UI/buttonrollover.wav' )

Add( 'ButtonBlip', 'buttons/blip1.wav' )
Add( 'Button1', 'buttons/button1.wav' )
Add( 'Button2', 'buttons/button2.wav' )
Add( 'Button3', 'buttons/button3.wav' )
Add( 'Button4', 'buttons/button4.wav' )
Add( 'Button5', 'buttons/button5.wav' )
Add( 'Button6', 'buttons/button6.wav' )
Add( 'Button8', 'buttons/button8.wav' )
Add( 'Button9', 'buttons/button9.wav' )
Add( 'Button10', 'buttons/button10.wav' )
Add( 'Button11', 'buttons/blip1.wav' )
Add( 'Button12', 'buttons/blip1.wav' )
Add( 'Button13', 'buttons/blip1.wav' )
Add( 'Button14', 'buttons/button14.wav' )
Add( 'Button15', 'buttons/button15.wav' )
Add( 'Button16', 'buttons/button16.wav' )
Add( 'Button17', 'buttons/button17.wav' )
Add( 'Button18', 'buttons/button18.wav' )
Add( 'Button19', 'buttons/button19.wav' )

Add( 'CombineButtonLocked', 'buttons/combine_button_locked.wav' )
Add( 'CombineButton1', 'buttons/combine_button1.wav' )
Add( 'CombineButton2', 'buttons/combine_button2.wav' )
Add( 'CombineButton3', 'buttons/combine_button3.wav' )
Add( 'CombineButton4', 'buttons/combine_button_locked.wav' )
Add( 'CombineButton5', 'buttons/combine_button5.wav' )
Add( 'CombineButton6', 'buttons/combine_button_locked.wav' )
Add( 'CombineButton7', 'buttons/combine_button7.wav' )

Add( 'LightswitchButton', 'buttons/lightswitch2.wav' )

for i = 1, 8 do Add( 'LeverButton'..tostring( i ), 'buttons/lever'..tostring( i )..'.wav' ) end