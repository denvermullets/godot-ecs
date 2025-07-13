class_name Entity
extends RefCounted

var id: int
var components: Dictionary = {}

static var next_id: int = 0

func _init():
	id = next_id
	next_id += 1

func add_component(component: Component) -> Component:
	var component_type = component.get_script().get_global_name()
	if component_type == "":
		component_type = component.get_script().resource_path
	component.entity_id = id
	components[component_type] = component
	return component

func get_component(component_type: String) -> Component:
	return components.get(component_type)

func has_component(component_type: String) -> bool:
	return components.has(component_type)

func remove_component(component_type: String) -> bool:
	return components.erase(component_type)