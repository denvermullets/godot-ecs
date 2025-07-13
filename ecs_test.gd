extends Node2D

var ecs_world: ECSWorld
var input_system: InputSystem

func _ready():
	ecs_world = ECSWorld.new()
	
	var hunger_system = HungerSystem.new(ecs_world)
	var health_system = HealthSystem.new(ecs_world)
	input_system = InputSystem.new(ecs_world)
	
	ecs_world.add_system(hunger_system)
	ecs_world.add_system(health_system)
	ecs_world.add_system(input_system)
	
	_create_test_entity()

func _create_test_entity():
	var entity = ecs_world.create_entity()
	
	entity.add_component(PositionComponent.new(entity.id, 100, 100))
	entity.add_component(HealthComponent.new(entity.id, 100))
	entity.add_component(HungerComponent.new(entity.id, 100, 10.0))
	entity.add_component(NameComponent.new(entity.id, "Test Animal"))
	entity.add_component(ClickableComponent.new(entity.id, Rect2(0, 0, 50, 50)))

func _process(delta):
	ecs_world.update(delta)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		input_system.handle_click(event.position)

func _draw():
	var entities = ecs_world.get_entities_with_components(["PositionComponent", "HealthComponent"])
	
	for entity in entities:
		var pos_comp = entity.get_component("PositionComponent") as PositionComponent
		var health_comp = entity.get_component("HealthComponent") as HealthComponent
		var name_comp = entity.get_component("NameComponent") as NameComponent
		
		var color = Color.GREEN
		if health_comp.get_health_percentage() < 0.5:
			color = Color.YELLOW
		if health_comp.get_health_percentage() < 0.25:
			color = Color.RED
		
		draw_circle(pos_comp.get_vector2(), 25, color)
		
		if name_comp:
			var font = ThemeDB.fallback_font
			draw_string(font, pos_comp.get_vector2() + Vector2(0, -30), 
						name_comp.name, HORIZONTAL_ALIGNMENT_CENTER, -1, 16)