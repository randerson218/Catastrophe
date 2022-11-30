extends CanvasLayer

signal transitioned


func transition():
	visible = true
	$AnimationPlayer.play("fade_to_white")
	print("Fading to black")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_white":
		print("Emit signal")
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
		
		
	if anim_name =="fade_to_normal":
		print("Fade to normal")
		get_tree().change_scene("res://scenes/FirstLevel.tscn")
