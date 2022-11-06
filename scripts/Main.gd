extends Node2D

export(PackedScene) var fish_scene

var random = RandomNumberGenerator.new()
var water_left = 0
var water_right = 0

func _ready():
	randomize()
	new_game()
	#water_left = $Water.position.x/2 - ($Water.texture.get_width() * $Water.scale.x)
	#water_right = $Water.position.x/2 + ($Water.texture.get_width() * $Water.scale.x)
	
	var edge_distance = ($Water.texture.get_width() * $Water.scale.x)/2
	
	water_left = $Water.position.x - edge_distance
	water_right= $Water.position.x + edge_distance

func _process(delta):
	var allfish = get_tree().get_nodes_in_group("fish")
	
	for fish in allfish:
		if fish.position.x <= water_left + 100:
			fish.swimming_right = true
		if fish.position.x >= water_right:
			fish.queue_free()
			

func game_over():
	$MobTimer.stop()

func new_game():
	$StartTimer.start()
	var fish_spawned = 0
	while fish_spawned < 50:
		spawn_fish()
		fish_spawned +=1
	

func spawn_fish():
	# Create a new instance of the Mob scene.
	var mob = fish_scene.instance()
	
	mob.add_to_group("fish")
	
	if get_tree().get_nodes_in_group("fish").size() < 50:
		# Choose a random location on Path2D.
		#var mob_spawn_location = get_node("FishPath/FishSpawnLocation")
		var mob_spawn_location = Vector2($Water.position.x,$Water.position.y)
		
		#var mob_spawn_location_offset = Vector2(randf_range(-1*$Water.get_rect()[2,0],$Water.get_rect()[2,1]),randf_range(0,120))
		var water_width = ($Water.texture.get_width() * $Water.scale.x)
		var water_height = ($Water.texture.get_height() * $Water.scale.y)
		
		var width_offset = random.randf_range(-water_width/2,water_width/2)
		var height_offset = random.randf_range((-water_height/2)+50,(water_height/2)-50)

		# Set the mob's position to a random location
		mob.position = mob_spawn_location + Vector2(width_offset,height_offset)
		
		var rand_direction = random.randi_range(0,100)
		if rand_direction > 50:
			mob.swimming_right = true
		else:
			mob.swimming_right = false
		
		
		# Spawn the mob by adding it to the Main scene.
		add_child(mob)
		
func _on_StartTimer_timeout():
	$MobTimer.start()
	
func _on_MobTimer_timeout():
	spawn_fish()
