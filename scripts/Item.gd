extends Node2D

export(Texture) var icon
export(String) var material_string

func pick_up():
	get_tree().call_group("Inventory", "add_item", self)
	get_parent().remove_child(self)

func highlight(is_hl):
	if is_hl:
		get_node("Sprite").modulate = Color(1, 0.7, 0.7)
	else:
		get_node("Sprite").modulate = Color(1, 1, 1)

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
				pick_up()
			else:
				player.say("I can't reach it from here")
