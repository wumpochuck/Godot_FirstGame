extends Node2D


func _ready():
	pass


var ShopButtonSwitcher = 0
var MaxLeftRange = 16
var x = 0

func _on_shop_button_pressed():
	if ShopButtonSwitcher == 0:
		$ShopButton/ShopText.text = "Close"
		x = 0
		while x <= MaxLeftRange:
			x += 1
			move_local_x(-32)
			await get_tree().create_timer(0.001).timeout
		ShopButtonSwitcher = 1
	else:
		$ShopButton/ShopText.text = "Shop"
		x = 0
		while x <= MaxLeftRange:
			x += 1
			move_local_x(32)
			await get_tree().create_timer(0.001).timeout
		ShopButtonSwitcher = 0





