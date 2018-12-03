extends ItemList

var inventory_items = []
var item_materials = []
var known_spells = {}

func _ready():
	add_item(load("res://scenes/items/Pistol.tscn").instance())

func add_item(item):
	inventory_items.append(item)
	item_materials.append(item.material_string)
	var idx = get_item_count()
	add_icon_item(item.icon)
	var tooltip = item.name + "\n\n - "
	if item.material_string != null:
		 tooltip += item.material_string
	
	set_item_tooltip(idx, tooltip)
	set_item_tooltip_enabled(idx, true)

func remove_item(idx):
	inventory_items.erase(idx)
	.remove_item(idx)
	
func add_spell(spell, mats):
	known_spells[spell] = mats

func try_cast_spell(clear):
	var cur_items = get_selected_items()
	
	# Generate a list of selected materials
	var mats = []
	for i in cur_items:
		mats.append(item_materials[i])
	mats.sort()
	
	for key in known_spells.keys():
		known_spells[key].sort()
		if known_spells[key].size() != mats.size():
			continue
		
		var equal = true
		for i in range(mats.size()):
			if known_spells[key][i] != mats[i]:
				equal = false
				break
		if equal:
			if clear:
				for idx in cur_items:
					remove_item(idx)
			return key
	return null