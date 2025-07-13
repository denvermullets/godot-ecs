class_name PoopSystem
extends System

func update(delta: float):
	var animals = get_entities_with_components(["AnimalComponent", "PositionComponent"])
	
	for animal in animals:
		var animal_comp = animal.get_component("AnimalComponent") as AnimalComponent
		var pos_comp = animal.get_component("PositionComponent") as PositionComponent
		
		animal_comp.last_poop_time += delta
		
		if animal_comp.last_poop_time >= animal_comp.poop_interval:
			create_pellet(pos_comp.position + Vector2(randf_range(-30, 30), 30))
			animal_comp.last_poop_time = 0.0

func create_pellet(pos: Vector2):
	var pellet = world.create_entity()
	pellet.add_component(PositionComponent.new(pellet.id, pos))
	pellet.add_component(PelletComponent.new(pellet.id, 10))
	pellet.add_component(SpriteComponent.new(pellet.id))