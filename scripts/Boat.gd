extends KinematicBody2D


export var speed = 150 # How fast the player will move (pixels/sec).
export var gravity := 2000

var velocity := Vector2.ZERO
var screen_size # Size of the game window.
onready var player = get_node("../Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	change_animation()
	toggle_in_boat()
		

# warning-ignore:unused_argument
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

func toggle_in_boat():
	if Input.is_action_just_pressed("boat_key") and player.in_boat == false:
		player.in_boat = true
		$BoatCamera.make_current()
		player.position = position
		
		#disable player collision while in boat and enable boat collision
		get_node("../Player/CollisionShape2D").disabled = true
		$CollisionPolygon2D.disabled = false
		
	elif Input.is_action_just_pressed("boat_key") and player.in_boat == true:
		#change player to being in boat and make boat camera active
		player.in_boat = false
		get_node("../Player/AnimatedSprite/PlayerCamera").make_current()
		#move player out of boat with collision disabled and renable player collision
		get_node("../Player/CollisionShape2D").disabled = false
		player.position = Vector2(0,0)
		$CollisionPolygon2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
