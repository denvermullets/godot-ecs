class_name PositionComponent
extends Component

var position: Vector2

func _init(id: int = -1, pos: Vector2 = Vector2.ZERO):
	super._init(id)
	self.position = pos