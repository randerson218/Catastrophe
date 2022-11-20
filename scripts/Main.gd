extends Node2D

export(PackedScene) var fish_scene
var random = RandomNumberGenerator.new()
onready var TownPoint = get_node("TownPoint")
onready var Player = get_node("Player")

#Offset from top and bottom of water to spawn fish
export var spawn_offset = 25
#Maximum fish to spawn
export var MAX_FISH = 1000
#Fish to spawn on initial load
var init_fish = int(MAX_FISH/2)

#Checks if its the first load of the scene
var first_load = true

#Distance from center of water to left and right edge of water
onready var water_half_width = ($Water.texture.get_width() * $Water.scale.x)/2
#Distance from center of water to top and bottom edge of water
onready var water_half_height = ($Water.texture.get_height()* $Water.scale.y/2)
#Right edge of water
onready var water_right= $Water.global_position.x + water_half_width


#Fish Arrays
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

func _ready():
	randomize()
	new_game()

func _process(delta):
	spawn_fish()
	
	if TownPoint != null:
		if Player.position.x < TownPoint.position.x:
			Globals.prev_scene = get_tree().current_scene.filename
			get_tree().change_scene("res://scenes/Town1.tscn")

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
	
	if rarity == "Common":
		var i = random.randi_range(0,common.size()-1)
		mob = common[i].instance()
		mob.worth = 5
	elif rarity == "Uncommon":
		var i = random.randi_range(0,uncommon.size()-1)
		mob = uncommon[i].instance()
		mob.worth = 10
	elif rarity == "Rare":
		var i = random.randi_range(0,rare.size()-1)
		mob = rare[i].instance()
		mob.worth = 15
	elif rarity == "Boss":
		var i = random.randi_range(0,boss.size()-1)
		mob = boss[i].instance()
		mob.worth = 20
	
	mob.add_to_group("fish")
	mob.add_to_group(rarity)
	
	mob.position.x = $Water.position.x + random.randf_range(-water_half_width,water_half_width)
	mob.position.y = $Water.position.y + random.randf_range(-water_half_height + spawn_offset,water_half_height - spawn_offset)
	
	mob.water_right = water_right
	
	
	if get_tree().get_nodes_in_group("fish").size() < MAX_FISH:
		var rand_direction = random.randi_range(0,100)
		if rand_direction > 50:
			mob.swimming_right = true
		else:
			mob.swimming_right = false

		if !first_load:# Spawn the mob by adding it to the Main scene.
			if !$Camera.get_visible_rect().has_point(mob.position):
				add_child(mob)
		else:
			add_child(mob)

