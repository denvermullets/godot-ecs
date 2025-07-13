class_name HungerSystem
extends System

func update(delta: float):
	var animals = get_entities_with_components(["AnimalComponent", "ClothingComponent"])
	
	for animal in animals:
		var animal_comp = animal.get_component("AnimalComponent") as AnimalComponent
		var clothing_comp = animal.get_component("ClothingComponent") as ClothingComponent
		
		# Calculate hunger decrease with clothing reduction
		var hunger_decrease = 1.0 * delta
		if clothing_comp:
			hunger_decrease *= (1.0 - clothing_comp.get_hunger_reduction())
		
		animal_comp.decrease_hunger(int(hunger_decrease))