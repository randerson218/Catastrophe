extends KinematicBody2D


export var speed = 150 # How fast the player will move (pixels/sec).
export var gravity := 2000
export var money = 0

var in_boat = false
var in_control = true
var velocity := Vector2.ZERO
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !in_boat:
		change_animation()
	else:
		$AnimatedSprite.play("boat")
	if Input.is_action_just_pressed("reset_player"):
		position = Vector2(0,0)
	

func _physics_process(delta: float) -> void:
	# reset horizontal velocity
	velocity.x = 0
	
	if in_control and !in_boat:
		# set horizontal velocity
		if Input.is_action_pressed("move_right"):
			velocity.x += speed
		if Input.is_action_pressed("move_left"):
			velocity.x -= speed

	if in_boat:
		#$CollisionShape2D.disabled = true
		z_index = -2
	else:
		#$CollisionShape2D.disabled = false
		z_index = 0
		velocity.y += gravity * delta
	

	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)

func change_animation():
	# face left or right
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true
	
	if velocity.y < 0: # negative Y is up
		if velocity.x != 0:
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("idle")
	elif velocity.y > 0:
		$AnimatedSprite.play("idle")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")	
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
