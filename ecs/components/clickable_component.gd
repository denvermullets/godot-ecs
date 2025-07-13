class_name ClickableComponent
extends Component

var bounds: Rect2
var enabled: bool

func _init(entity_id: int = -1, bounds: Rect2 = Rect2(), enabled: bool = true):
	super._init(entity_id)
	self.bounds = bounds
	self.enabled = enabled

func is_point_inside(point: Vector2) -> bool:
	return enabled and bounds.has_point(point)