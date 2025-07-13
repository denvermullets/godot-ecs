class_name System
extends RefCounted

var world: World

func update(delta: float):
	pass

func get_entities_with_components(component_names: Array) -> Array:
	return world.get_entities_with_components(component_names)