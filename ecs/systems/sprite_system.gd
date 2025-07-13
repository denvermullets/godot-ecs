class_name SpriteSystem
extends System

var game_scene: Node2D

func _init(scene: Node2D):
	self.game_scene = scene

func update(delta: float):
	# Update animal sprites
	var animals = get_entities_with_components(["AnimalComponent", "PositionComponent", "SpriteComponent"])
	for animal in animals:
		var animal_comp = animal.get_component("AnimalComponent") as AnimalComponent
		var pos_comp = animal.get_component("PositionComponent") as PositionComponent
		var sprite_comp = animal.get_component("SpriteComponent") as SpriteComponent
		
		if not sprite_comp.sprite_node:
			create_animal_sprite(animal, sprite_comp, pos_comp)
		else:
			update_animal_sprite(animal_comp, sprite_comp, pos_comp)
	
	# Update pellet sprites
	var pellets = get_entities_with_components(["PelletComponent", "PositionComponent", "SpriteComponent"])
	for pellet in pellets:
		var pellet_comp = pellet.get_component("PelletComponent") as PelletComponent
		var pos_comp = pellet.get_component("PositionComponent") as PositionComponent
		var sprite_comp = pellet.get_component("SpriteComponent") as SpriteComponent
		
		pellet_comp.lifetime += delta
		
		if not sprite_comp.sprite_node:
			create_pellet_sprite(pellet, sprite_comp, pos_comp)
		
		# Remove old pellets
		if pellet_comp.lifetime > 30.0:
			if sprite_comp.sprite_node:
				sprite_comp.sprite_node.queue_free()
			world.destroy_entity(pellet.id)

func create_animal_sprite(entity: Entity, sprite_comp: SpriteComponent, pos_comp: PositionComponent):
	var sprite = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	sprite.scale = Vector2(0.3, 0.3)
	sprite.position = pos_comp.position
	sprite.set_meta("entity_id", entity.id)
	sprite.set_meta("entity_type", "animal")
	
	game_scene.add_child(sprite)
	sprite_comp.sprite_node = sprite

func create_pellet_sprite(entity: Entity, sprite_comp: SpriteComponent, pos_comp: PositionComponent):
	var sprite = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	sprite.scale = Vector2(0.1, 0.1)
	sprite.position = pos_comp.position
	sprite.modulate = Color.GOLD
	sprite.set_meta("entity_id", entity.id)
	sprite.set_meta("entity_type", "pellet")
	
	game_scene.add_child(sprite)
	sprite_comp.sprite_node = sprite

func update_animal_sprite(animal_comp: AnimalComponent, sprite_comp: SpriteComponent, pos_comp: PositionComponent):
	if sprite_comp.sprite_node:
		sprite_comp.sprite_node.position = pos_comp.position
		
		# Change color based on hunger
		if animal_comp.is_starving():
			sprite_comp.current_color = Color.RED
		elif animal_comp.is_hungry():
			sprite_comp.current_color = Color.ORANGE
		else:
			sprite_comp.current_color = Color.WHITE
		
		sprite_comp.sprite_node.modulate = sprite_comp.current_color