extends KinematicBody2D

const GRAVITY = 0
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1


func _ready():
	pass
	
func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("swim")
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)

