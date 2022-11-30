extends Control

var is_paused = false setget set_is_paused
var lure_cost = 500
var capacity_cost = 50

func _unhandled_input(event):
	if event.is_action_pressed("market"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value
	#get_tree().paused = is_paused
	visible = is_paused
	
func _process(delta):
	$CapacityCost.text = "$" + str(capacity_cost)
	$HookCost.text = "$" + str(lure_cost)
	$FishCost.text = "$" + str(Globals.worth_in_boat)


func _on_BuyButton_pressed():
	if Globals.player_money >= capacity_cost:
		Globals.max_capacity += 1
		Globals.player_money -= capacity_cost
		capacity_cost *= 2
		$Audio.play()
		print(Globals.max_capacity)
		print("Players money:" + str(Globals.player_money))

func _on_BuyLureButton_pressed():
	if Globals.player_money >= lure_cost:
		Globals.lure_level += 1
		Globals.player_money -= lure_cost
		lure_cost *= 2
		$Audio.play()
		print(Globals.lure_level)
		print("Players money:" + str(Globals.player_money))

func _on_SellButton_pressed():
	Globals.player_money += Globals.worth_in_boat
	Globals.worth_in_boat = 0
	Globals.num_fish_in_boat = 0
	$Audio.play()
	print("Players money:" + str(Globals.player_money))
