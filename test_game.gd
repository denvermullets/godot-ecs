extends Node

func _ready():
	print("Testing ECS system...")
	
	# Create world
	var world = World.new()
	
	# Create entity
	var entity = world.create_entity()
	entity.add_component(AnimalComponent.new(entity.id, "Test Bear"))
	entity.add_component(PositionComponent.new(entity.id, Vector2(100, 100)))
	
	print("Entity created with ID: ", entity.id)
	print("Animal component: ", entity.get_component("AnimalComponent"))
	print("Position component: ", entity.get_component("PositionComponent"))
	
	# Test system
	var hunger_system = HungerSystem.new()
	world.add_system(hunger_system)
	
	print("ECS test complete!")
	get_tree().quit()