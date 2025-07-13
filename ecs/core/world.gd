class_name World
extends RefCounted

var entities: Dictionary = {}
var systems: Array = []

func create_entity() -> Entity:
	var entity = Entity.new()
	entities[entity.id] = entity
	return entity

func destroy_entity(entity_id: int):
	entities.erase(entity_id)

func get_entity(entity_id: int) -> Entity:
	return entities.get(entity_id)

func add_system(system):
	system.world = self
	systems.append(system)

func update(delta: float):
	for system in systems:
		system.update(delta)

func get_entities_with_components(component_names: Array) -> Array:
	var result = []
	for entity in entities.values():
		var has_all = true
		for component_name in component_names:
			if not entity.has_component(component_name):
				has_all = false
				break
		if has_all:
			result.append(entity)
	return result