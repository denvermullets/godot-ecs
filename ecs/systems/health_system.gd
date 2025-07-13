class_name HealthSystem
extends System

func update(delta: float):
	var entities = get_entities_with_components(["HealthComponent"])
	
	for entity in entities:
		var health_comp = entity.get_component("HealthComponent") as HealthComponent
		
		if not health_comp.is_alive():
			_handle_death(entity)

func _handle_death(entity: Entity):
	world.destroy_entity(entity.id)