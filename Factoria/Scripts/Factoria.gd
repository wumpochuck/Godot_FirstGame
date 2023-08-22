extends Node

# --- Ебатория настроек --- #
var CounterForExitButton = 0
func _on_s_exit_button_pressed():
	var exitgametext = $Settings/S_ExitButton/S_ExitText
	if CounterForExitButton == 0:
		exitgametext.text = "Are u sure?"
		CounterForExitButton += 1
		await get_tree().create_timer(2).timeout
		CounterForExitButton -= 1
		exitgametext.text = "Exit Game"
		
	elif CounterForExitButton == 1:
		get_tree().quit()

# --- Ебатория при старте игры --- #
func _ready():

	var j = 0
	for i in get_tree().get_nodes_in_group("Buildings"):
		j += 1
		i.connect("pressed", Callable(self, "init_build_mode" + str(j)))

# --- Ебатория при выходе из игры --- #
func _exit_tree():
	pass

# --- Ебатория для кликов --- #
var coins = 1
var coinsPlus = 1
var multiplier = 1
var coinsPerClick = coinsPlus * multiplier
var coinsPerSec = 0
func _on_clicker_button_pressed():
	coins += coinsPerClick
	#var displaytext = $Clicker/DisplayCoins/DisplayText
	#coinsPerClick = coinsPlus * multiplier
	
	#displaytext.text = "Coins: "+str(coins)+"\nCoins per click: "+str(coinsPerClick)+"\nCoins per sec: "+str(coinsPerSec)


# --- Ебатория полного обновления всех нодов --- #
func full_update():
	# -- Сначала переменные -- #
	coinsPerClick = coinsPlus * multiplier
	
	# -- Потом ноды -- #
	var displaytext = $Clicker/DisplayCoins/DisplayText
	displaytext.text = "Coins: "+str(coins)+"\nCoins per click: "+str(coinsPerClick)+"\nCoins per sec: "+str(coinsPerSec)
	
	
	
		
func _physics_process(delta):
	full_update()


var index = 1
# Переменные Для Дома
var houseCounter = 0
var mnojitelHouse = 215
var housePrice

# Апдейт Дома
func house_update():
	housePrice = round(exp(houseCounter)*mnojitelHouse-115)
	var textHouse = $Shop/Buildings/VB/building1/TextureButton/Label
	var textLeftHouse = $Shop/Buildings/VB/building1/VBoxContainer/LabelCount
	textHouse.text = "Price: "+str(housePrice)+"$\n+10 to click"
	textLeftHouse.text = str(4-houseCounter)+" left"

	if houseCounter == 4:
		textHouse.text = "All Bought!"

# Спавн Дома
func init_build_mode1():
	house_update()
	if coins >= housePrice and houseCounter != 4:
		coins -= housePrice
		var slot = get_node('Field/GridContainer/Slot' + str(index))
		var child = TextureRect.new()
		if houseCounter < 4:
			if slot.get_child_count() == 0:
				child.texture = load("res://Assets/House128x128.png")
				slot.add_child(child)
				coinsPlus += 10
				#powered += 1
				houseCounter += 1
				index += 1
	elif houseCounter != 4:
		var textHouse = $Shop/Buildings/VB/building1/TextureButton/Label
		textHouse.text = "Not Enought!"
		await get_tree().create_timer(1).timeout
	if houseCounter > 1:
		mnojitelHouse = 560
	house_update()


var factoryCounter = 0
var factoryPrice

# Апдейт Завода
func factory_update():
	factoryPrice = round(exp(factoryCounter)*1200)
	var textFactory = $Shop/Buildings/VB/building2/TextureButton/Label
	var textLeftFactory = $Shop/Buildings/VB/building2/VBoxContainer/LabelCount
	textFactory.text = "Price: "+str(factoryPrice)+"$\nx"+str(multiplier)+" to click"
	textLeftFactory.text = str(4-factoryCounter) + " left"
	if factoryCounter == 0:
		textFactory.text = "Price: "+str(factoryPrice)+"$\nx"+str(1.5)+" to click"
	if factoryCounter == 4:
		textFactory.text = "All Bought!"

#Спавн Завода
func init_build_mode2():
	factory_update()
	if coins >= factoryPrice and factoryCounter != 4:
		coins -= factoryPrice
		var slot = get_node('Field/GridContainer/Slot' + str(index))
		var child = TextureRect.new()
		if factoryCounter < 4:
			if slot.get_child_count() == 0:
				child.texture = load("res://Assets/Завод.png")
				slot.add_child(child)
				multiplier += 1.5
				factoryCounter += 1
				index += 1
	elif factoryCounter != 4:
		var textFactory = $Shop/Buildings/VB/building2/TextureButton/Label
		textFactory.text = "Not Enought!"
		await get_tree().create_timer(1).timeout
	factory_update()

# CPS
func _on_timer_timeout():
	coins += coinsPerSec

var lakeCounter = 0
var lakePrice
var lakeCPS = 100

# Апдейт Озера
func lake_update():
	lakePrice = round(exp(lakeCounter)*11205)
	var textLake = $Shop/Buildings/VB/building3/TextureButton/Label
	var textLeftLake = $Shop/Buildings/VB/building3/VBoxContainer/LabelCount
	textLake.text = "Price: "+str(lakePrice)+"$\n+"+str(lakeCPS)+" to CPS"
	textLeftLake.text = str(4-lakeCounter) + " left"
	if lakeCounter == 0:
		textLake.text = "Price: "+str(lakePrice)+"$\n+"+str(lakeCPS)+" to CPS"
	if lakeCounter == 4:
		textLake.text = "All Bought!"

#Спавн Озера
func init_build_mode3():
	lake_update()
	if coins >= lakePrice and lakeCounter != 4:
		coins -= lakePrice
		var slot = get_node('Field/GridContainer/Slot' + str(index))
		var child = TextureRect.new()
		if lakeCounter < 4:
			if slot.get_child_count() == 0:
				child.texture = load("res://Assets/Озеро.png")
				slot.add_child(child)
				coinsPerSec += lakeCPS
				lakeCounter += 1
				lakeCPS += round(lakePrice/2400*(lakeCounter+1)) 
				index += 1
	elif lakeCounter != 4:
		var textLake = $Shop/Buildings/VB/building3/TextureButton/Label
		textLake.text = "Not Enought!"
		await get_tree().create_timer(1).timeout
	lake_update()
	

var parkCounter = 0
var parkPrice
var parkCPS = 1000
# Апдейт Парка
func park_update():
	parkPrice = round(exp(lakeCounter)*111205)
	var textPark = $Shop/Buildings/VB/building4/TextureButton/Label
	var textLeftPark = $Shop/Buildings/VB/building4/VBoxContainer/LabelCount
	textPark.text = "Price: "+str(parkPrice)+"$\n+"+str(parkCPS)+" to CPS"
	textLeftPark.text = str(4-parkCounter) + " left"
	if parkCounter == 0:
		textPark.text = "Price: "+str(parkPrice)+"$\n+"+str(parkCPS)+" to CPS"
	if parkCounter == 4:
		textPark.text = "All Bought!"

#Спавн Парка
func init_build_mode4():
	park_update()
	if coins >= parkPrice and parkCounter != 4:
		coins -= parkPrice
		var slot = get_node('Field/GridContainer/Slot' + str(index))
		var child = TextureRect.new()
		if parkCounter < 4:
			if slot.get_child_count() == 0:
				child.texture = load("res://Assets/Парк.png")
				slot.add_child(child)
				coinsPerSec += parkCPS
				parkCounter += 1
				parkCPS += round(parkPrice/12000*(lakeCounter+1)) 
				index += 1
	elif parkCounter != 4:
		var textPark = $Shop/Buildings/VB/building4/TextureButton/Label
		textPark.text = "Not Enought!"
		await get_tree().create_timer(1).timeout
	park_update()


