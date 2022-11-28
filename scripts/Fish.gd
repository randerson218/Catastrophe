extends KinematicBody2D

export var speed = 25
export var swimming_right = true
var water_right

var worth = 0
var on_hook=false

func _ready():
	if !swimming_right:
		self.scale.x = -1

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _process(delta):
	
	if !on_hook:
		if swimming_right:
			move_and_slide(Vector2(speed,0))
		else:
			move_and_slide(Vector2(-speed,0))
			
	else:
		on_Hook(get_node("../Hook").position)
	
	if $RayCast2D.is_colliding():
		swimming_right = true
		if !$RayCast2D.get_collider().is_in_group("fish"):
			self.scale.x *= -1
	
	#If the fish is colliding with boat catch box
	if $RayCast2D.get_collider() != null:
		if$RayCast2D.get_collider() == get_node("../Boat"):
			get_node("../Hook").fish_on_hook =false
			queue_free()
			Globals.worth_in_boat += worth
			Globals.num_fish_in_boat +=1
			print(Globals.worth_in_boat)
	
	if self.global_position.x > water_right:
		queue_free() 
	
func on_Hook(hookposition):
	self.on_hook = true
	self.position = hookposition
