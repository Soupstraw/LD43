extends Node2D

signal movement_input(dir)
signal spellcast(pos)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event is InputEventKey:
		var move_dir = Vector2(0,0)
		
		# Handle movement
		if Input.is_key_pressed(KEY_W):
			move_dir.y -= 1
		if Input.is_key_pressed(KEY_A):
			move_dir.x -= 1
		if Input.is_key_pressed(KEY_S):
			move_dir.y += 1
		if Input.is_key_pressed(KEY_D):
			move_dir.x += 1
		
		emit_signal("movement_input", move_dir.normalized())
		
	# Handle spellcasting
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("RMB"):
			var inv = get_tree().get_nodes_in_group("Inventory")[0]
			var spell = inv.try_cast_spell(false)
			if spell == null:
				get_tree().get_nodes_in_group("Player")[0].say("I don't think I can perform a ritual with these items")
				return
			inv.try_cast_spell(true)
			emit_signal("spellcast", get_global_mouse_position(), spell)