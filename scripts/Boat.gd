extends KinematicBody2D


export var speed = 400 # How fast the player will move (pixels/sec).

var velocity := Vector2.ZERO
var screen_size # Size of the game window.
var in_boat = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_animation()
	change_camera()
		

func _physics_process(delta: float) -> void:
	
	# reset horizontal velocity
	velocity.x = 0

	# set horizontal velocity
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed

	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)

func change_animation():
	# face left or right
	if velocity.x > 0:
		$Sprite.flip_h = false
		$CollisionPolygon2D.scale.x = abs($Sprite.scale.x)
		
	elif velocity.x < 0:
		$Sprite.flip_h = true
		$CollisionPolygon2D.scale.x *= -1

func change_camera():
	if Input.is_action_just_pressed("interact_key") and in_boat == false:
		$BoatCamera.make_current()
		in_boat = true
	elif Input.is_action_just_pressed("interact_key") and in_boat == true:
		get_node("../Player/AnimatedSprite/PlayerCamera").make_current()
		in_boat = false

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
