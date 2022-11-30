extends Control

const SceneTwo = preload("res://scenes/FirstLevel.tscn")

func _on_Resume_pressed():
	$TransitionScreen.transition()
	
func _on_TransitionScreen_transitioned():
	$CanvasLayer.get_child(0).queue_free()
	get_tree().change_scene("res://scenes/FirstLevel.tscn")

func _on_Quit_pressed():
	get_tree().quit()
