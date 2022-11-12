extends Area2D

export var reel_speed = 50

var hook_cast = false
var fish_on_hook = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true

func _process(delta):
	
	if Input.is_action_just_pressed("interact_key"):
		hook_cast = true
		get_node("../Camera").target_node = self
			
	if Input.is_action_pressed("up_key"):
		self.position.y -= reel_speed * delta
		
	if Input.is_action_pressed("down_key"):
		self.position.y += reel_speed * delta
	
	if get_node("../Player").in_boat and hook_cast:
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
		self.position.x = get_node("../Boat").position.x
	
	for body in get_overlapping_bodies():
		if body.is_in_group("fish") and !fish_on_hook:
			body.on_hook = true
			fish_on_hook = true
	#update line for fishing line 
	update()
		
func _draw():
	if hook_cast:
		draw_line(Vector2(0,-5),Vector2(0,-(self.position.y + get_node("../Boat").position.y)),Color(255.0,255.0,255.0),1.0)
