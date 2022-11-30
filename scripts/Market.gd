extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("market"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value
	#get_tree().paused = is_paused
	visible = is_paused
	
func _process(delta):
	$CapacityCost.text = "$" + str(Globals.capacity_cost)
	if Globals.lure_level < 3:
		$HookCost.text = "$" + str(Globals.lure_cost)
	else:
		$HookCost.text = "SOLD"
	$FishCost.text = "$" + str(Globals.worth_in_boat)


func _on_BuyButton_pressed():
	if Globals.player_money >= Globals.capacity_cost:
		Globals.max_capacity += 1
		Globals.player_money -= Globals.capacity_cost
		Globals.capacity_cost *= 2
		$Audio.play()
		print(Globals.max_capacity)
		print("Players money:" + str(Globals.player_money))

func _on_BuyLureButton_pressed():
	if Globals.player_money >= Globals.lure_cost and Globals.lure_level < 3:
		Globals.lure_level += 1
		Globals.player_money -= Globals.lure_cost
		Globals.lure_cost *= 2
		$Audio.play()
		print(Globals.lure_level)
		print("Players money:" + str(Globals.player_money))

func _on_SellButton_pressed():
	Globals.player_money += Globals.worth_in_boat
	Globals.worth_in_boat = 0
	Globals.num_fish_in_boat = 0
	$Audio.play()
	print("Players money:" + str(Globals.player_money))
