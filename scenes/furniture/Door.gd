extends Sprite

export(bool) var is_locked = true
export(bool) var is_open = false

func _ready():
	if is_open:
		open_door()

func open_door():
	get_node("LightOccluder2D").hide()
	remove_child(get_node("StaticBody2D"))
	set_texture(preload("res://sprites/furniture/door_open.png"))



func on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("LMB"):
			var player = get_tree().get_nodes_in_group("Player")[0]
			var dist = player.global_position.distance_to(global_position)
			
			#Do a raycast
			var space_state = get_world_2d().direct_space_state
			var ignore = [player, get_node("Area2D")]
			var res = space_state.intersect_ray(global_position, player.global_position, ignore, 2)
			if not res.empty():
				return
			
			if dist < 32:
				if is_locked:
					player.say("It's locked")
				else:
					open_door()
			else:
				player.say("I can't reach it from here")
