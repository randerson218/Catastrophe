extends RichTextLabel


func _ready():
	pass
	
func _process(delta):
	self.text = str("$"+str(Globals.player_money))
