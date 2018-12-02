extends Node

signal movement_input(dir)

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
