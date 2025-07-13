class_name ECSWorld
extends RefCounted

const Entity = preload("res://ecs/core/entity.gd")

var entities: Dictionary = {}
var systems: Array = []

func create_entity():
	var entity = Entity.new()
	entities[entity.id] = entity
	return entity

func destroy_entity(entity_id: int) -> bool:
	return entities.erase(entity_id)

func get_entity(entity_id: int):
	return entities.get(entity_id)

func add_system(system):
	systems.append(system)

func remove_system(system):
	systems.erase(system)

func update(delta: float):
	for system in systems:
		system.update(delta)

func get_entities_with_components(component_types: Array) -> Array:
	var matching_entities: Array = []
	
	for entity in entities.values():
		var has_all_components = true
		for component_type in component_types:
			if not entity.has_component(component_type):
				has_all_components = false
				break
		
		if has_all_components:
			matching_entities.append(entity)
	
	return matching_entities

func get_all_entities() -> Array:
	return entities.values()