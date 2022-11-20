extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Globals.prev_scene)
	print(Globals.worth_in_boat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.x > $TownExit.position.x:
		get_tree().change_scene(Globals.prev_scene)
