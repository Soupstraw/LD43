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

func spawn_glyph(pos, spell):
	var spell_path
	if spell == "Fire":
		spell_path = "res://scenes/spells/fire_glyph.tscn"
		draw_glyph(spell_path, get_global_mouse_position())
	elif spell == "Lockpick":
		spell_path = "res://scenes/spells/lockpick_glyph.tscn"
		var things = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position())
		for t in things:
			if t.collider.is_in_group("Door"):
				draw_glyph(spell_path, t.collider)
				return
		say("I should be pointing at a door")
		return
	else:
		say("Congratulations, you found a bug!")
		return
	

func draw_glyph(spell_path, pos):
	get_tree().get_nodes_in_group("Inventory")[0].try_cast_spell(false)
	var glyph = load(spell_path).instance()
	get_node(glyph_node).add_child(glyph)
	glyph.set_target(pos)
	var glyph_pos = Vector2(floor(position.x / 16) * 16 + 8, floor(position.y / 16) * 16 + 8)
	glyph.set_position(glyph_pos)

func set_move_dir(dir):
	targetVelocity = dir

func deal_damage(val, type="normal"):
	health -= val
	emit_signal("health_changed", health)
	
	var particles = get_node("Particles2D")
	particles.restart()
	particles.emitting = true;
	
	# Death check
	if health <= 0:
		get_parent().remove_child(self)

func say(text):
	get_node("Label").text = text
	
	yield(get_tree().create_timer(text.length() * 0.1), "timeout")
	if get_node("Label").text == text:
		get_node("Label").text = ""