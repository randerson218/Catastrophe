extends CanvasLayer


func _ready():
	self.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		self.show()
