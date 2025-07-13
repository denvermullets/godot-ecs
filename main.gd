extends Control

# ECS World
var world: World

# Game state
var currency: int = 200
var food_count: int = 0
var selected_animal: Entity = null

# UI references
@onready var currency_label: Label = $UI/TopBar/CurrencyLabel
@onready var food_label: Label = $UI/TopBar/FoodLabel
@onready var game_area: Node2D = $GameArea
@onready var animal_info: VBoxContainer = $UI/RightPanel
@onready var animal_name_label: Label = $UI/RightPanel/NameLabel
@onready var hunger_label: Label = $UI/RightPanel/HungerLabel
@onready var happiness_label: Label = $UI/RightPanel/HappinessLabel


# Dialog for renaming
var rename_dialog: AcceptDialog

func _ready():
	setup_ecs()
	setup_ui()
	if animal_info:
		animal_info.visible = false
	
	# Initialize UI with starting values
	call_deferred("update_ui")

func setup_ecs():
	world = World.new()
	
	# Add systems
	world.add_system(HungerSystem.new())
	world.add_system(PoopSystem.new())
	world.add_system(SpriteSystem.new(game_area))

func setup_ui():
	# Create rename dialog
	rename_dialog = AcceptDialog.new()
	rename_dialog.title = "Rename Animal"
	rename_dialog.size = Vector2(300, 150)
	
	var line_edit = LineEdit.new()
	line_edit.name = "NameInput"
	line_edit.placeholder_text = "Enter new name"
	rename_dialog.add_child(line_edit)
	
	add_child(rename_dialog)
	rename_dialog.confirmed.connect(_on_rename_confirmed)

func _process(delta):
	if world:
		world.update(delta)
		update_ui()

func update_ui():
	if currency_label:
		currency_label.text = "Currency: " + str(currency)
	
	if food_label:
		food_label.text = "Food: " + str(food_count)
	
	if selected_animal and world and world.entities.has(selected_animal.id):
		update_animal_info()

func update_animal_info():
	if not selected_animal:
		return
		
	var animal_comp = selected_animal.get_component("AnimalComponent") as AnimalComponent
	if animal_comp:
		if animal_name_label:
			animal_name_label.text = "Name: " + animal_comp.name
		if hunger_label:
			hunger_label.text = "Hunger: " + str(animal_comp.hunger) + "/100"
		if happiness_label:
			happiness_label.text = "Happiness: " + str(animal_comp.happiness) + "/100"

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		handle_click(event.position)

func handle_click(click_pos: Vector2):
	# Check if clicked on an animal or pellet
	for child in game_area.get_children():
		if child is Sprite2D:
			var sprite_rect = Rect2(
				child.position - child.texture.get_size() * child.scale / 2,
				child.texture.get_size() * child.scale
			)
			
			if sprite_rect.has_point(click_pos):
				var entity_id = child.get_meta("entity_id")
				var entity_type = child.get_meta("entity_type")
				var entity = world.get_entity(entity_id)
				
				if entity_type == "animal":
					select_animal(entity)
				elif entity_type == "pellet":
					collect_pellet(entity, child)
				return

func select_animal(animal: Entity):
	selected_animal = animal
	animal_info.visible = true
	update_animal_info()

func collect_pellet(pellet: Entity, sprite: Sprite2D):
	var pellet_comp = pellet.get_component("PelletComponent") as PelletComponent
	if pellet_comp:
		currency += pellet_comp.value
		sprite.queue_free()
		world.destroy_entity(pellet.id)

# Button handlers
func _on_buy_animal_pressed():
	print("Buy animal button pressed!")
	if currency >= 50 and get_animal_count() < 10:
		currency -= 50
		create_animal()
		print("Animal created!")

func _on_buy_food_pressed():
	print("Buy food button pressed!")
	if currency >= 5:
		currency -= 5
		food_count += 1

func _on_feed_animal_pressed():
	if selected_animal and food_count > 0:
		var animal_comp = selected_animal.get_component("AnimalComponent") as AnimalComponent
		if animal_comp:
			food_count -= 1
			animal_comp.feed(30)

func _on_add_sweater_pressed():
	if selected_animal and currency >= 25:
		var clothing_comp = selected_animal.get_component("ClothingComponent") as ClothingComponent
		if clothing_comp and not clothing_comp.has_item("sweater"):
			currency -= 25
			clothing_comp.add_item("sweater", {"hunger_reduction": 0.3})
			
			# Visual indication of sweater
			var sprite_comp = selected_animal.get_component("SpriteComponent") as SpriteComponent
			if sprite_comp and sprite_comp.sprite_node:
				sprite_comp.sprite_node.modulate = sprite_comp.sprite_node.modulate * Color.CYAN

func _on_rename_animal_pressed():
	if selected_animal:
		var animal_comp = selected_animal.get_component("AnimalComponent") as AnimalComponent
		if animal_comp:
			var line_edit = rename_dialog.get_node("NameInput") as LineEdit
			line_edit.text = animal_comp.name
			rename_dialog.popup_centered()

func _on_rename_confirmed():
	if selected_animal:
		var animal_comp = selected_animal.get_component("AnimalComponent") as AnimalComponent
		var line_edit = rename_dialog.get_node("NameInput") as LineEdit
		if animal_comp and line_edit.text.strip_edges() != "":
			animal_comp.name = line_edit.text.strip_edges()

func _on_sell_animal_pressed():
	if selected_animal:
		var sprite_comp = selected_animal.get_component("SpriteComponent") as SpriteComponent
		if sprite_comp and sprite_comp.sprite_node:
			sprite_comp.sprite_node.queue_free()
		
		currency += 25  # Sell for half price
		world.destroy_entity(selected_animal.id)
		selected_animal = null
		animal_info.visible = false

func create_animal():
	var animal = world.create_entity()
	
	# Random position in game area
	var spawn_pos = Vector2(
		randf_range(100, 700),
		randf_range(150, 400)
	)
	
	animal.add_component(PositionComponent.new(animal.id, spawn_pos))
	animal.add_component(AnimalComponent.new(animal.id, "Bear " + str(randi() % 1000)))
	animal.add_component(SpriteComponent.new(animal.id))
	animal.add_component(ClothingComponent.new(animal.id))

func get_animal_count() -> int:
	return world.get_entities_with_components(["AnimalComponent"]).size()