extends Sprite

export(NodePath) var animation_player

func _ready():
	find_node(animation_player).play("glyph_appear")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
