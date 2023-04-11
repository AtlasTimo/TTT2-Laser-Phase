CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_laser_phaser_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_laser_phaser")

	form:MakeHelp({
		label = "help_laser_phaser_menu"
	})

	form:MakeCheckBox({
		label = "label_laser_phaser_enable_xray",
		serverConvar = "ttt_laser_phaser_enable_xray"
	})

	form:MakeCheckBox({
		label = "label_laser_phaser_annonnymous",
		serverConvar = "ttt_laser_phaser_annonnymous"
	})

	form:MakeCheckBox({
		label = "label_laser_phaser_enable_beep",
		serverConvar = "ttt_laser_phaser_enable_beep"
	})

	form:MakeSlider({
		label = "label_laser_phaser_range",
		serverConvar = "ttt_laser_phaser_range",
		min = 500,
		max = 10000,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_laser_phaser_sighting_range",
		serverConvar = "ttt_laser_phaser_sighting_range",
		min = 20,
		max = 10000,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_laser_phaser_beep_range",
		serverConvar = "ttt_laser_phaser_beep_range",
		min = 20,
		max = 10000,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_laser_phaser_overload_damage",
		serverConvar = "ttt_laser_phaser_overload_damage",
		min = 0,
		max = 300,
		decimal = 0
	})
end
