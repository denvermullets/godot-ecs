class_name RenderSystem
extends System

var canvas_layer: CanvasLayer

func _init(ecs_world, canvas_layer: CanvasLayer):
	super._init(ecs_world)
	self.canvas_layer = canvas_layer

func update(delta: float):
	var entities = get_entities_with_components(["SpriteComponent", "PositionComponent"])
	
	for entity in entities:
		var sprite_comp = entity.get_component("SpriteComponent") as SpriteComponent
		var pos_comp = entity.get_component("PositionComponent") as PositionComponent
		
		if sprite_comp.texture != null:
			_draw_sprite(sprite_comp, pos_comp)

func _draw_sprite(sprite_comp: SpriteComponent, pos_comp: PositionComponent):
	pass