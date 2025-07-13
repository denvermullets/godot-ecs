class_name System
extends RefCounted

var world

func _init(ecs_world):
	self.world = ecs_world

func update(delta: float):
	pass

func get_entities_with_components(component_types: Array) -> Array:
	return world.get_entities_with_components(component_types)