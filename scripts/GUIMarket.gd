extends CanvasLayer


func _ready():
	self.hide()

func _process(delta):
	var player_at_market = get_node("../MarketArea").overlaps_body(get_node("../Player"))
	if Input.is_action_just_pressed("boat_key") and player_at_market and !self.is_visible():
		self.show()
	elif Input.is_action_just_pressed("boat_key"):
		self.hide()
