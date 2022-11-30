extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var current_scene = get_tree().current_scene.filename
	if current_scene == "res://scenes/FirstLevel.tscn":
		self.stream = load("res://resources/audio/boat-buds-mark-sparling.mp3")
		self.playing = true
	elif current_scene == "res://scenes/SecondLevel.tscn":
		self.stream = load("res://resources/audio/Cave.wav")
		self.playing = true
	else:
		self.stream = load("res://resources/audio/Town.wav")
		self.playing = true
