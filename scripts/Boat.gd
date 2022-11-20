extends KinematicBody2D


export var speed = 150 # How fast the player will move (pixels/sec).

var velocity := Vector2.ZERO
var screen_size # Size of the game window.
var at_dock


onready var player = get_node("../Player")
onready var player_sprite = get_node("../Player/AnimatedSprite")
onready var dock = get_node("../Dock")
onready var hook = get_node("../Hook")


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player.add_collision_exception_with(self)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	change_animation()
	toggle_in_boat()
	
	at_dock = dock.overlaps_body(self) and dock.overlaps_body(player)

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	#reset horizontal velocity
	velocity.x = 0
	
	if player.in_control and player.in_boat:
		# set horizontal velocity
		if Input.is_action_pressed("move_right") and self.position.x < get_node("../MaxRight").position.x:
			velocity.x += speed
		if Input.is_action_pressed("move_left"):
			velocity.x -= speed
		
		if player_sprite.flip_h == false:
			player.position = $BoatSeat.global_position
		else:
			player.position = $BoatSeat.global_position + Vector2(32,0)
		
	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)
	

func change_animation():
	# face left or right
	if velocity.x > 0:
		$Sprite.flip_h = false
		
	elif velocity.x < 0:
		$Sprite.flip_h = true
	
	if player.in_boat:
		player_sprite.flip_h = $Sprite.flip_h

func toggle_in_boat():
	if Input.is_action_just_pressed("boat_key") and !player.in_boat and at_dock:
		player.in_boat = true
		get_node("../Camera").target_node = self

	elif Input.is_action_just_pressed("boat_key") and player.in_boat and at_dock and !hook.hook_cast:
		#change player to being in boat and make boat camera active
		get_node("../Camera").target_node = get_node("../Player")
		player.position = get_node("../BoatExit").position - Vector2(-16,-16)
		player.in_boat = false

func start(pos):
	position = pos
	show()
