class_name SpriteComponent
extends Component

var sprite_node: Sprite2D
var base_color: Color
var current_color: Color

func _init(id: int = -1):
	super._init(id)
	self.base_color = Color.WHITE
	self.current_color = Color.WHITE