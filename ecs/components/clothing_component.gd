class_name ClothingComponent
extends Component

var items: Dictionary = {}

func _init(id: int = -1):
	super._init(id)

func add_item(item_name: String, item_data: Dictionary):
	items[item_name] = item_data

func has_item(item_name: String) -> bool:
	return items.has(item_name)

func get_hunger_reduction() -> float:
	var reduction = 0.0
	for item in items.values():
		if item.has("hunger_reduction"):
			reduction += item.hunger_reduction
	return reduction