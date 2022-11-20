extends Camera2D
 
export (NodePath) var TargetNodepath = null
var target_node
export (float) var lerpspeed = 0.05
export (float) var zoomspeed = 0.05
var is_focused_on_hook
var is_zoomed
 
func _ready():
		target_node  = get_node(TargetNodepath)
		self.position = target_node.position
		self.zoom = Vector2(0.5,0.5)

func _process(delta):
	if is_zoomed:
		self.zoom = Vector2(lerp(self.zoom.x,0.25,zoomspeed),lerp(self.zoom.y,0.25,zoomspeed))
	else:
		self.zoom = Vector2(lerp(self.zoom.x,0.5,zoomspeed),lerp(self.zoom.y,0.5,zoomspeed))
	
	
	self.position = lerp(self.position, target_node.position, lerpspeed)
	
func get_visible_rect():
	var totalviewport = self.get_viewport().get_visible_rect()
	
	#gets dimensions with current zoom level
	var camera_width = totalviewport.size[0] * self.zoom.x
	var camera_height = totalviewport.size[1] * self.zoom.y
	
	#gets the point for rect origin
	var rect_origin = self.get_camera_screen_center() - Vector2(camera_width/2,camera_height/2)
	
	#actual visible rect
	var visible_rect = Rect2 (rect_origin,Vector2(camera_width,camera_height))

	return visible_rect
	
