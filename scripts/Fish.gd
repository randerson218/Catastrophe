extends KinematicBody2D

export var speed = 25
export var swimming_right = true

var on_hook=false
var boat_height
var PRICE = 10

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
		
func on_Hook(hookposition):
	self.on_hook = true
	self.position = hookposition
	if self.position.y <= boat_height:
		queue_free()
		#PUT PAYMENT HERE
