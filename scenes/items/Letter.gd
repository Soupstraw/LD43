extends "res://scripts/Item.gd"

export(String) var spell_name
export(Array, String) var required_materials
export(Array, String) var diary_entry

func pick_up():
	get_tree().get_nodes_in_group("Diary")[0].add_entry(diary_entry)
	get_tree().get_nodes_in_group("Inventory")[0].add_spell(spell_name, required_materials)
	.pick_up()