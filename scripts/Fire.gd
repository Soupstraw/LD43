extends Node2D

export(int) var damage = 1
export(float) var interval = 0.5

func _ready():
	get_node("AnimationPlayer").play("burning")
	
	while true:
		for obj in get_node("Area2D").get_overlapping_bodies():
			print(obj.get_class())
			if obj.is_in_group("Character"):
				obj.deal_damage(damage)
		
		# Remove once animation stops
		if not get_node("AnimationPlayer").is_playing():
			get_parent().remove_child(self)
			return
		
		# Wait until next tick
		yield(get_tree().create_timer(interval), "timeout")