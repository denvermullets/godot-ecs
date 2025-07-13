class_name SpriteComponent
extends Component

var texture: Texture2D
var scale: Vector2
var rotation: float
var modulate: Color

func _init(entity_id: int = -1, texture: Texture2D = null):
	super._init(entity_id)
	self.texture = texture
	self.scale = Vector2.ONE
	self.rotation = 0.0
	self.modulate = Color.WHITE