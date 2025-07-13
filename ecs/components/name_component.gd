class_name NameComponent
extends Component

var name: String

func _init(entity_id: int = -1, name: String = ""):
	super._init(entity_id)
	self.name = name