extends Node2D

export(PackedScene) var fish_scene

export var spawn_height_offset = 16
export var spawn_left_offset = 16
export var MAX_FISH = 1000

var init_fish = int(MAX_FISH/2)
var random = RandomNumberGenerator.new()
var water_left = 0
var water_right = 0
var first_load = true

func _ready():
	randomize()
	new_game()
	
	var edge_distance = ($Water.texture.get_width() * $Water.scale.x)/2
	
	water_left = $Water.position.x - edge_distance
	water_right= $Water.position.x + edge_distance

func _process(delta):
	var allfish = get_tree().get_nodes_in_group("fish")
	
	for fish in allfish:
		#if fish.position.x <= water_left + spawn_left_offset:
		#	fish.swimming_right = true
		#	fish.scale.x *= -1
		if fish.position.x >= water_right:
			fish.queue_free()
			
	spawn_fish()

func new_game():
	var fish_spawned = 0
	while fish_spawned < init_fish:
		spawn_fish()
		fish_spawned +=1
	first_load = false

func get_fish_rarity():
	var random_float = randf()

	if random_float < 0.70:
		# 70% chance of being returned.
		return "Common"
	elif random_float < 0.85:
		# 15% chance of being returned.
		return "Uncommon"
	elif random_float < 0.95:
		# 10% chance of being returned.
		return "Rare"
	else:
		# 5% chance of being boss
		return "Boss"
	

func spawn_fish():
	var rarity = get_fish_rarity()
	var mob
	
	var common = [
	preload("res://scenes/fish_scenes/RedFish.tscn"),
	preload("res://scenes/fish_scenes/BlueFish.tscn"),
	preload("res://scenes/fish_scenes/GreenFish.tscn"),
	preload("res://scenes/fish_scenes/OrangeFish.tscn")
	]
	
	var uncommon = [preload("res://scenes/fish_scenes/Greyfish.tscn"),
	preload("res://scenes/fish_scenes/Fish.tscn"),
	preload("res://scenes/fish_scenes/SkeletonFish1.tscn"),
	preload("res://scenes/fish_scenes/SkeletonFish2.tscn"),
	preload("res://scenes/fish_scenes/SkeletonFish3.tscn"),
	preload("res://scenes/fish_scenes/SkeletonFish4.tscn")
	]
	
	var rare = [preload("res://scenes/fish_scenes/Blowfish.tscn"),
	preload("res://scenes/fish_scenes/Longfish.tscn"),
	preload("res://scenes/fish_scenes/SkeletonFish5.tscn"),]
	
	var boss = [preload("res://scenes/fish_scenes/Angler.tscn"),
	preload("res://scenes/fish_scenes/Sawfish.tscn"),
	preload("res://scenes/fish_scenes/Shark.tscn")]
	
	
	if rarity == "Common":
		var i = random.randi_range(0,common.size()-1)
		mob = common[i].instance()
	elif rarity == "Uncommon":
		var i = random.randi_range(0,uncommon.size()-1)
		mob = uncommon[i].instance()
	elif rarity == "Rare":
		var i = random.randi_range(0,rare.size()-1)
		mob = rare[i].instance()
	elif rarity == "Boss":
		var i = random.randi_range(0,boss.size()-1)
		mob = boss[i].instance()
	
	mob.add_to_group("fish")
	mob.add_to_group(rarity)
	
	if get_tree().get_nodes_in_group("fish").size() < MAX_FISH:
		# Choose a random location on Path2D.
		#var mob_spawn_location = get_node("FishPath/FishSpawnLocation")
		var mob_spawn_location = Vector2($Water.position.x,$Water.position.y)
		
		#var mob_spawn_location_offset = Vector2(randf_range(-1*$Water.get_rect()[2,0],$Water.get_rect()[2,1]),randf_range(0,120))
		var water_width = ($Water.texture.get_width() * $Water.scale.x)
		var water_height = ($Water.texture.get_height() * $Water.scale.y)
		
		var width_offset = random.randf_range(-water_width/2,water_width/2)
		var height_offset = random.randf_range((-water_height/2)+spawn_height_offset,
		(water_height/2)-spawn_height_offset)

		# Set the mob's position to a random location
		mob.position = mob_spawn_location + Vector2(width_offset,height_offset)
		
		var rand_direction = random.randi_range(0,100)
		if rand_direction > 50:
			mob.swimming_right = true
		else:
			mob.swimming_right = false

		if !first_load:# Spawn the mob by adding it to the Main scene.
			if !get_viewport_rect().has_point(mob.position):
				add_child(mob)
		else:
			add_child(mob)

