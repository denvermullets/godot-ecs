class_name InputSystem
extends System

func update(delta: float):
	pass

func handle_click(mouse_pos: Vector2):
	var clickable_entities = get_entities_with_components(["ClickableComponent", "PositionComponent"])
	
	for entity in clickable_entities:
		var clickable_comp = entity.get_component("ClickableComponent") as ClickableComponent
		var pos_comp = entity.get_component("PositionComponent") as PositionComponent
		
		var adjusted_bounds = Rect2(
			pos_comp.get_vector2() + clickable_comp.bounds.position,
			clickable_comp.bounds.size
		)
		
		if adjusted_bounds.has_point(mouse_pos):
			_on_entity_clicked(entity)

func _on_entity_clicked(entity):
	pass