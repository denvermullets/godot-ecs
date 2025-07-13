class_name HealthComponent
extends Component

var current_health: int
var max_health: int

func _init(entity_id: int = -1, max_health: int = 100):
	super._init(entity_id)
	self.max_health = max_health
	self.current_health = max_health

func take_damage(amount: int):
	current_health = max(0, current_health - amount)

func heal(amount: int):
	current_health = min(max_health, current_health + amount)

func is_alive() -> bool:
	return current_health > 0

func get_health_percentage() -> float:
	return float(current_health) / float(max_health)