class_name HungerComponent
extends Component

var current_hunger: int
var max_hunger: int
var hunger_rate: float

func _init(entity_id: int = -1, max_hunger: int = 100, hunger_rate: float = 1.0):
	super._init(entity_id)
	self.max_hunger = max_hunger
	self.current_hunger = max_hunger
	self.hunger_rate = hunger_rate

func increase_hunger(amount: int):
	current_hunger = max(0, current_hunger - amount)

func feed(amount: int):
	current_hunger = min(max_hunger, current_hunger + amount)

func is_hungry() -> bool:
	return current_hunger < max_hunger * 0.5

func is_starving() -> bool:
	return current_hunger <= 0

func get_hunger_percentage() -> float:
	return float(current_hunger) / float(max_hunger)