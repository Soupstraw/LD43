extends Panel

var text_entries = ["Not sure how to start this diary.."]
var current_entry = 0

func add_entry(entry):
	
	var final_entry = ""
	for line in entry:
		final_entry += line + "\n"
	
	text_entries.append(final_entry)
	current_entry = text_entries.size() - 1
	get_node("HBoxContainer/LeftPage/Label").text = text_entries[current_entry]
	show()

func next_entry():
	current_entry = min(current_entry + 1, text_entries.size() - 1)
	get_node("HBoxContainer/LeftPage/Label").text = text_entries[current_entry]

func prev_entry():
	current_entry = max((current_entry - 1), 0)
	get_node("HBoxContainer/LeftPage/Label").text = text_entries[current_entry]
