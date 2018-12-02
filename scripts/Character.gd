extends KinematicBody2D

signal health_changed(health)

var targetVelocity = Vector2()
var velocity = Vector2()

export(float) var speed = 32
export(float) var acceleration = 10
export(int) var health = 10

export(NodePath) var glyph_node = NodePath()

func _ready():
	emit_signal("health_changed", health)

func _process(delta):
	var diff = targetVelocity - velocity
	velocity += diff.clamped(1) * delta * acceleration
	move_and_slide(velocity * delta * speed)
	
	# Make character face the right way
	if velocity.x > 0:
		get_node("Sprite").flip_h = true
	else:
		get_node("Sprite").flip_h = false

func spawn_glyph(pos):
	var glyph = load("res://scenes/spells/fire_glyph.tscn").instance()
	get_node(glyph_node).add_child(glyph)
	glyph.set_position(pos)

func set_move_dir(dir):
	targetVelocity = dir

func deal_damage(val, type="normal"):
	health -= val
	emit_signal("health_changed", health)
	
	# Death check
	if health <= 0:
		get_parent().remove_child(self)