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
	
