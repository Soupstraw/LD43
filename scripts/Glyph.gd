extends Node2D

export(NodePath) var animation_player = NodePath()

func _ready():
	find_node(animation_player).play("glyph_appear")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_spawned():
	var fire = load("res://scenes/Fire.tscn").instance()
	add_child(fire)
	fire.set_position(Vector2(0,-8))