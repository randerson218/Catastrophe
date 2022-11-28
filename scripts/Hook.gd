extends Area2D

export var reel_speed = 50

var hook_cast = false
var fish_on_hook = false
var min_depth
var max_depth
var hook_focused = false
onready var boat = get_node("../Boat")
onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
	self.add_to_group("hook")
	min_depth = boat.position.y
	
	var water = get_node("../Water")
	max_depth = min_depth + water.texture.get_height() * water.scale.y - 100
	

func _process(delta):
	
	if Input.is_action_just_pressed("interact_key") and !hook_cast and player.in_boat:
		hook_cast = true
		toggle_enabled()
		get_node("../Camera").target_node = self
		$Audio.play()
	elif Input.is_action_just_pressed("interact_key") and hook_cast and !fish_on_hook:
		hook_cast = false
		get_node("../Camera").target_node = boat
		toggle_enabled()
			
	if hook_cast:	
		if Input.is_action_pressed("up_key") and self.position.y > min_depth:
			self.position.y -= reel_speed * delta
			
		if Input.is_action_pressed("down_key") and self.position.y < max_depth:
			self.position.y += reel_speed * delta
	
	if player.in_boat and hook_cast:
		self.position.x = boat.position.x
	#update line for fishing line 
	update()
	
	if Globals.num_fish_in_boat >= Globals.max_capacity:
		$CollisionShape2D.disabled = true
		
func _draw():
	if hook_cast:
		draw_line(Vector2(0,-5),Vector2(0,-(self.position.y + boat.position.y-10)),Color(255.0,255.0,255.0),1.0)
		
func _on_Hook_body_entered(body):
	if body.is_in_group("fish") and !fish_on_hook:
		body.on_hook = true
		fish_on_hook = true

func toggle_enabled():
	$Sprite.visible = !$Sprite.visible
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled
	get_node("../Camera").is_zoomed = !get_node("../Camera").is_zoomed
