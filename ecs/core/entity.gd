class_name Entity
extends RefCounted

var id: int
var components: Dictionary = {}

static var next_id: int = 0

func _init():
	id = next_id
	next_id += 1

func add_component(component):
	var component_name = component.get_script().get_global_name()
	if component_name == "":
		component_name = component.get_script().resource_path.get_file().get_basename()
	component.entity_id = id
	components[component_name] = component
	return component

func get_component(component_name: String):
	return components.get(component_name)

func has_component(component_name: String) -> bool:
	return components.has(component_name)

func remove_component(component_name: String):
	components.erase(component_name)