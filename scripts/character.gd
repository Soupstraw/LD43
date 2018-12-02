extends KinematicBody2D

var targetVelocity = Vector2()
var velocity = Vector2()

export(float) var speed = 32
export(float) var acceleration = 10

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var diff = targetVelocity - velocity
	velocity += diff.clamped(1) * delta * acceleration
	move_and_slide(velocity * delta * speed)
	
	# Make character face the right way
	if velocity.x > 0:
		get_node("Sprite").flip_h = true
	else:
		get_node("Sprite").flip_h = false


func set_move_dir(dir):
	targetVelocity = dir
