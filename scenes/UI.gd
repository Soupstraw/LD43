extends CanvasLayer

func update_health(health):
	get_node("GUI/BloodCounter").text = "Remaining blood: " + str(health)