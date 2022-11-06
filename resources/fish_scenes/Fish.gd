extends RigidBody2D

export var speed = 50
export var swimming_right = true

var on_hook=false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _process(delta):
	if !on_hook:
		if swimming_right:
			self.position.x += speed * delta
			$AnimatedSprite.flip_h = false
		else:
			self.position.x -= speed * delta
			$AnimatedSprite.flip_h = true
