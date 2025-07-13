class_name AnimalComponent
extends Component

var name: String
var hunger: int
var max_hunger: int
var last_poop_time: float
var poop_interval: float
var happiness: int

func _init(id: int = -1, animal_name: String = "Bear"):
	super._init(id)
	self.name = animal_name
	self.hunger = 100
	self.max_hunger = 100
	self.last_poop_time = 0.0
	self.poop_interval = 5.0
	self.happiness = 100

func is_hungry() -> bool:
	return hunger < 50

func is_starving() -> bool:
	return hunger <= 0

func feed(amount: int):
	hunger = min(max_hunger, hunger + amount)
	happiness = min(100, happiness + 10)

func decrease_hunger(amount: int):
	hunger = max(0, hunger - amount)
	if hunger < 25:
		happiness = max(0, happiness - 5)