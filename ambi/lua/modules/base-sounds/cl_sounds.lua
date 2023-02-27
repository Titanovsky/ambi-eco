local Sound, S = Ambi.Packages.Out( 'sound, sounds' )
local Add = Sound.Add

-- --------------------------------------------------------------------------------------------------------------------------------------
--? Ambi ?--
Add( 'AmbiError', 'ambi/ui/error3.wav' )
Add( 'Error', 'ambi/ui/error3.wav' )
Add( 'AmbiNotify1', 'ambi/ui/click9.wav' )
Add( 'AmbiNotify1Error', 'ambi/ui/error2.wav' )

-- --------------------------------------------------------------------------------------------------------------------------------------
--? Garry's Mod ?--
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

-- --------------------------------------------------------------------------------------------------------------------------------------
--? Ambi Sounds ?--
Add( 'Beep1L4D2', 'ambi/ui/beep1_l4d.wav' )
Add( 'Beep2L4D2', 'ambi/ui/beep2_l4d.wav' )
Add( 'Beep3L4D2', 'ambi/ui/beep3_l4d.wav' )

Add( 'Bell1', 'ambi/ui/bell1.mp3' )
Add( 'Bell2', 'ambi/ui/bell2.mp3' )
Add( 'Bell3', 'ambi/ui/bell3.mp3' )
Add( 'Bell4', 'ambi/ui/bell4.mp3' )
Add( 'Bell5', 'ambi/ui/bell5.mp3' )
Add( 'Bell6', 'ambi/ui/bell6.mp3' )
Add( 'Bell7', 'ambi/ui/bell7.mp3' )
Add( 'Bell8', 'ambi/ui/bell8.mp3' )

Add( 'Bonk1', 'ambi/ui/bonk1.mp3' )
Add( 'Bonk2', 'ambi/ui/bonk2.mp3' )
Add( 'Bonk3', 'ambi/ui/bonk3.mp3' )

for i = 1, 13 do
    Add( 'Button'..i, 'ambi/ui/button'..i..'.wav' )
end

for i = 1, 2 do
    Add( 'ButtonTU'..i, 'ambi/ui/button'..i..'_tower_unite.wav' )
end

for i = 1, 3 do
    Add( 'ButtonVC'..i, 'ambi/ui/button'..i..'_vc.wav' )
end

Add( 'ClickMinecraft', 'ambi/ui/click_minecraft.mp3' )
Add( 'ClickTU', 'ambi/ui/click_tower_unite.wav' )

for i = 1, 20 do
    Add( 'Click'..i, 'ambi/ui/click'..i..'.wav' )
end
Add( 'Click1', 'ambi/ui/click1.mp3' )
Add( 'Click3', 'ambi/ui/click3.ogg' )
Add( 'Click5', 'ambi/ui/click5.mp3' )
Add( 'Click6', 'ambi/ui/click6.mp3' )
Add( 'Click13', 'ambi/ui/click13.mp3' )
Add( 'Click14', 'ambi/ui/click14.mp3' )
Add( 'Click20', 'ambi/ui/click20.ogg' )

Add( 'Ding1', 'ambi/ui/ding1.ogg' )

Add( 'ErrorWindowsXP', 'ambi/ui/error_windows_xp.mp3' )
Add( 'ErrorWindows10', 'ambi/ui/error_windows10.mp3' )
Add( 'ErrorWindows98', 'ambi/ui/error_windows98.mp3' )

Add( 'Error1', 'ambi/ui/error1.mp3' )
Add( 'Error2', 'ambi/ui/error2.wav' )
Add( 'Error3', 'ambi/ui/error3.wav' )
Add( 'Error4', 'ambi/ui/error4.mp3' )

for i = 1, 9 do
    Add( 'Hover'..i, 'ambi/ui/hover'..i..'.wav' )
end
Add( 'HoverTU', 'ambi/ui/hover_tower_unite.wav' )
Add( 'HoverVC1', 'ambi/ui/hover1_vc.wav' )
Add( 'HoverVC2', 'ambi/ui/hover2_vc.wav' )

Add( 'Notification1', 'ambi/ui/notification1.mp3' )
Add( 'Notification2', 'ambi/ui/notification2.mp3' )
Add( 'NotificationWhatsApp', 'ambi/ui/notification_whatsapp.mp3' )
Add( 'NotificationSamsung', 'ambi/ui/notification_samsung.mp3' )
Add( 'NotificationDiscord', 'ambi/ui/notification_discord.mp3' )

for i = 1, 3 do
    Add( 'PickupVC'..i, 'ambi/ui/pickup'..i..'_vc.wav' )
end

for i = 1, 5 do
    Add( 'Select'..i, 'ambi/ui/select'..i..'.wav' )
end
Add( 'Select6', 'ambi/ui/select6.ogg' )
Add( 'Select7', 'ambi/ui/select7.ogg' )

for i = 1, 4 do
    Add( 'SpottingIcon'..i, 'ambi/ui/spotting_icon'..i..'.ogg' )
end

Add( 'Success1', 'ambi/ui/success1.wav' )

for i = 1, 20 do
    Add( 'Switch'..i, 'ambi/ui/switch'..i..'.wav' )
end

Add( 'Throwing1', 'ambi/ui/throwing1.mp3' )

for i = 1, 2 do
    Add( 'Whoosh'..i, 'ambi/ui/whoosh'..i..'.mp3' ) --!: fix Invalid sample rate (48000) for sound
end

Add( 'Win1', 'ambi/ui/win1.ogg' )
Add( 'Win1L4D', 'ambi/ui/win1_l4d.wav' )
Add( 'Win2L4D', 'ambi/ui/win2_l4d.wav' )

Add( 'CompleteSA', 'ambi/other/complete_gta_sa.mp3' )
Add( 'CompleteQuest', 'ambi/other/complete_quest.ogg' )
Add( 'CompleteRank', 'ambi/other/complete_rank_up.mp3' )
Add( 'CompleteStars', 'ambi/other/complete_stars.mp3' ) --!: fix Invalid sample rate (48000) for sound
Add( 'DonationAlerts', 'ambi/other/donationalerts.mp3' )
Add( 'DonatePay', 'ambi/other/donatepay.mp3' )

-- --------------------------------------------------------------------------------------------------------------------------------------
--? Ambi Sounds Extended ?--

Add( 'UwU', 'ambi/fun/uwu.mp3' )

Add( 'Blurred - Shadows', 'ambi/halloween/blurred_shadows.ogg' ) --!: fix Invalid sample rate (48000) for sound
Add( 'HalloweenDiscord', 'ambi/halloween/discord_halloween.ogg' )
Add( 'HalloweenEvent', 'ambi/halloween/halloween_event.ogg' )

Add( 'HM_Headshot', 'ambi/hitmarker/headshot.wav' )
Add( 'HM_Hit', 'ambi/hitmarker/hit.wav' )

Add( 'Money_Coin1', 'ambi/money/coin1.ogg' )
Add( 'Money_Counter1', 'ambi/money/counter1.ogg' )
Add( 'Money_Send1', 'ambi/money/send1.ogg' )
Add( 'Money_Send2', 'ambi/money/send2.ogg' )

Add( 'BF5_AwardDogtag1', 'ambi/ui/bf5/award_dogtag1.ogg' )
Add( 'BF5_AwardRibon1', 'ambi/ui/bf5/award_ribon1.ogg' )
Add( 'BF5_AwardWarbong1', 'ambi/ui/bf5/award_warbong1.ogg' )
Add( 'BF5_CounterTick1', 'ambi/ui/bf5/counter_tick1.ogg' )
Add( 'BF5_Collapse1', 'ambi/ui/bf5/collapse1.ogg' )
Add( 'BF5_Collapse1', 'ambi/ui/bf5/collapse1.ogg' )
Add( 'BF5_Deathcam1', 'ambi/ui/bf5/deathcam1.ogg' )
Add( 'BF5_Deploy1', 'ambi/ui/bf5/deploy1.ogg' )
Add( 'BF5_FadeoutText1', 'ambi/ui/bf5/fadeout_text1.ogg' )
Add( 'BF5_PlayerSquadWipe1', 'ambi/ui/bf5/player_squad_wipe1.ogg' )
Add( 'BF5_Tooltip1', 'ambi/ui/bf5/tooltip1.ogg' )

for i = 1, 19 do
    Add( 'BF5_Capture'..i, 'ambi/ui/bf5/capture'..i..'.ogg' )
end

for i = 1, 5 do
    Add( 'BF5_Highlight'..i, 'ambi/ui/bf5/highlight'..i..'.ogg' )
end

for i = 1, 2 do
    Add( 'BF5_Interact'..i, 'ambi/ui/bf5/interact'..i..'.ogg' )
end

for i = 1, 18 do
    Add( 'BF5_KillMessage'..i, 'ambi/ui/bf5/kill_message'..i..'.ogg' )
end

for i = 2, 3 do
    Add( 'BF5_Losing'..i, 'ambi/ui/bf5/losing'..i..'.ogg' )
end

for i = 1, 5 do
    Add( 'BF5_MajorScoreEvent'..i, 'ambi/ui/bf5/major_score_event'..i..'.ogg' )
end

for i = 1, 2 do
    Add( 'BF5_Purchase'..i, 'ambi/ui/bf5/purchase'..i..'.ogg' )
end

for i = 1, 9 do
    Add( 'BF5_Show'..i, 'ambi/ui/bf5/show'..i..'.ogg' )
end

for i = 1, 2 do
    Add( 'BF5_Squad'..i, 'ambi/ui/bf5/squad'..i..'.ogg' )
end

for i = 1, 4 do
    Add( 'BF5_WarStories'..i, 'ambi/ui/bf5/war_stories'..i..'.ogg' )
end

-- --------------------------------------------------------------------------------------------------------------------------------------
--? CSZ ?--

--TODO 
-- local i = 0
-- timer.Create( 'adssd', 1.2, 4, function()
--     i = i + 1
--     local tag = 'BF5_WarStories'..i
--     surface.PlaySound( tag )
--     chat.AddText( tag )
-- end )

-- --------------------------------------------------------------------------------------------------------------------------------------
--? Painkiller ?--

--TODO