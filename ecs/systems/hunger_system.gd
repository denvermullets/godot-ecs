class_name HungerSystem
extends System

func update(delta: float):
	var entities = get_entities_with_components(["HungerComponent"])
	
	for entity in entities:
		var hunger_comp = entity.get_component("HungerComponent") as HungerComponent
		
		hunger_comp.increase_hunger(int(hunger_comp.hunger_rate * delta))
		
		if hunger_comp.is_starving():
			_handle_starvation(entity)

func _handle_starvation(entity: Entity):
	var health_comp = entity.get_component("HealthComponent") as HealthComponent
	if health_comp:
		health_comp.take_damage(1)