extends TileMap


@onready var timer: Timer = $Timer


enum Layer {Black, White}
var current_layer = Layer.Black
var previous_layer = Layer.White
func _ready() -> void:
	pass
	

func _on_timer_timeout() -> void:
	print(tile_set.get_physics_layer_collision_layer(Layer.White))
	match current_layer:
		
		Layer.Black:
			print("On Layer Black!")
			
			# make the previous White layer transparent
			set_layer_modulate(previous_layer, Color(255,255,255,0.075))
			# make the current Black layer solid colored
			set_layer_modulate(current_layer, Color(0,0,0,1.0))
			
			# turn OFF previous white layer physics if NOT OFF already
			#turn_off_previous_layer_physics()
			if tile_set.get_physics_layer_collision_layer(Layer.White) == 1:
				tile_set.set_physics_layer_collision_layer(Layer.White, 0)
				print("turned off white layer collision")
			# turn ON current layer physics if NOT ON already
			if tile_set.get_physics_layer_collision_layer(Layer.Black) == 0:
				tile_set.set_physics_layer_collision_layer(Layer.Black, 1)
				print("turned on black layer collision")
			print("-------------------")
			# turn ON current BLACK layer physics
			
			#set current layer to White for next iteration
			current_layer = Layer.White
			#set new previous layer to Black
			previous_layer = Layer.Black
			
		Layer.White:
			print("On Layer White!")
			set_layer_modulate(previous_layer, Color(0,0,0,0.075))
			set_layer_modulate(current_layer, Color(255,255,255,1.0))
			
			#turn_off_previous_layer_physics()
			if tile_set.get_physics_layer_collision_layer(Layer.Black) == 1:
				
				tile_set.set_physics_layer_collision_layer(Layer.Black, 0)
				print("turned off black layer collision")
			# turn ON current layer physics if NOT ON already
			if tile_set.get_physics_layer_collision_layer(Layer.White) == 0:
				tile_set.set_physics_layer_collision_layer(Layer.White, 1)
				print("turned on white layer collision")
			print("-------------------")
			
			#set current layer to Black for next iteration
			current_layer = Layer.Black
			#set new previous layer to White
			previous_layer = Layer.White
	
#func turn_off_previous_layer_physics():
	#if tile_set.get_physics_layer_collision_layer(previous_layer) == 1:
				#tile_set.set_physics_layer_collision_layer(previous_layer, 0)
				#
#func turn_on_current_layer_physics():
	#if tile_set.get_physics_layer_collision_layer(current_layer) == 0:
				#tile_set.set_physics_layer_collision_layer(current_layer, 1)
