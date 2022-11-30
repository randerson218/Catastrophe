extends Control

const SceneTwo = preload("res://scenes/FirstLevel.tscn")

func _on_Resume_pressed():
	$TransitionScreen.transition()


func _on_TransitionScreen_transitioned():
	self.get_child(1).queue_free()
	self.add_child(SceneTwo.instance())
	
	get_tree().change_scene("res://scenes/FirstLevel.tscn")

func _on_Quit_pressed():
	get_tree().quit()
