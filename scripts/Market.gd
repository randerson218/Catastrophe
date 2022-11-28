extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("market"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused




func _on_BuyButton_pressed():
	pass # Replace with function body.



func _on_BuyLureButton_pressed():
	pass # Replace with function body.


func _on_SellButton_pressed():
	pass # Replace with function body.
