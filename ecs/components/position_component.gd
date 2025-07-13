class_name PositionComponent
extends Component

var x: float
var y: float

func _init(entity_id: int = -1, x: float = 0.0, y: float = 0.0):
	super._init(entity_id)
	self.x = x
	self.y = y

func get_vector2() -> Vector2:
	return Vector2(x, y)

func set_position(new_x: float, new_y: float):
	x = new_x
	y = new_y