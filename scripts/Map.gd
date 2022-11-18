extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("map"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_CaveButton_pressed():
	get_tree().change_scene("res://scenes/SecondLevel.tscn")
	self.is_paused = false



func _on_DesetButton_pressed():
	get_tree().change_scene("res://scenes/ThirdLevel.tscn")
	self.is_paused = false


func _on_ForestButton_pressed():
	get_tree().change_scene("res://scenes/FirstLevel.tscn")
	self.is_paused = false
