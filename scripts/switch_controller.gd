extends Node

@onready var timer: Timer = $Timer

@onready var tile_map: TileMap = $"../TileMap"

enum Layer {Black, White}
var current_layer = Layer.Black
var previous_layer = Layer.White
func _ready() -> void:
	pass
	

func _on_timer_timeout() -> void:
	match current_layer:
		
		Layer.Black:
			print("On Layer Black!")
			
			# make the previous White layer transparent
			tile_map.set_layer_modulate(previous_layer, Color(255,255,255,0.075))
			# make the current Black layer solid colored
			tile_map.set_layer_modulate(current_layer, Color(0,0,0,1.0))
			
			# turn OFF previous white layer physics if NOT OFF already
			turn_off_previous_layer_physics()
				
			# turn ON current layer physics if NOT ON already
			turn_off_current_layer_physics()
			# turn ON current BLACK layer physics
			
			#set current layer to White for next iteration
			current_layer = Layer.White
			#set new previous layer to Black
			previous_layer = Layer.Black
			
		Layer.White:
			print("On Layer White!")
			tile_map.set_layer_modulate(previous_layer, Color(0,0,0,0.075))
			tile_map.set_layer_modulate(current_layer, Color(255,255,255,1.0))
			
			# turn OFF previous white layer physics if NOT OFF already
			turn_off_previous_layer_physics()
				
			# turn ON current layer physics if NOT ON already
			turn_off_current_layer_physics()
			
			#set current layer to Black for next iteration
			current_layer = Layer.Black
			#set new previous layer to White
			previous_layer = Layer.White
	
func turn_off_previous_layer_physics():
	if tile_map.tile_set.get_physics_layer_collision_layer(previous_layer) == 1:
				tile_map.tile_set.set_physics_layer_collision_layer(previous_layer, 0)
				
func turn_off_current_layer_physics():
	if tile_map.tile_set.get_physics_layer_collision_layer(current_layer) == 0:
				tile_map.tile_set.set_physics_layer_collision_layer(current_layer, 1)
