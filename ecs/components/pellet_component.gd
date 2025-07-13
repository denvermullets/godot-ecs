class_name PelletComponent
extends Component

var value: int
var lifetime: float

func _init(id: int = -1, pellet_value: int = 10):
	super._init(id)
	self.value = pellet_value
	self.lifetime = 0.0