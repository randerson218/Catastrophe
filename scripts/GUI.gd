extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called w	visible()hen the node enters the scene tree for the first time.
func _ready():
	self.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		self.show()
