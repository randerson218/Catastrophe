extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_pivot_offset = rect_size/2
	self.rect_scale = Vector2(3,3)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CenterContainer_resized():
	rect_min_size = get_parent().rect_min_size * 1.5
