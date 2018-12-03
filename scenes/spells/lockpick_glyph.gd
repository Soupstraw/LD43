extends Node2D

var pos

func _ready():
	get_node("AnimationPlayer").play("glyph_appear")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_spawned():
	var things = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position())
	pos.get_parent().open_door()

func set_target(pos):
	self.pos = pos
