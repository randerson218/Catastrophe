extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.x > $TownExit.position.x:
		get_tree().change_scene(Globals.prev_scene)
