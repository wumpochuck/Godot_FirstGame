extends Node2D


var SettingButtonSwitcher = 0
var MaxLeftRange = 16
var x = 0

func _ready():
	pass


func _on_settings_button_pressed():
	if SettingButtonSwitcher == 0:
		$SettingsButton/SettingsText.text = "Close"
		x = 0
		while x <= MaxLeftRange:
			x += 1
			move_local_x(16)
			await get_tree().create_timer(0.001).timeout
		SettingButtonSwitcher = 1
	else:
		$SettingsButton/SettingsText.text = "Settings"
		x = 0
		while x <= MaxLeftRange:
			x += 1
			move_local_x(-16)
			await get_tree().create_timer(0.001).timeout
		SettingButtonSwitcher = 0

