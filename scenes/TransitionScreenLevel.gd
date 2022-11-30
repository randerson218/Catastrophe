extends CanvasLayer


func _ready():
	$AnimationPlayer.play("fade_to_normal")
	
func _on_AnimationPlayer_animation_finished(anim_name):
		pass


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
