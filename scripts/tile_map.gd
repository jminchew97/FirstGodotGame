extends TileMap


@onready var timer: Timer = $Timer


enum Layer {White, Black}
var current_layer = Layer.Black
var previous_layer = Layer.White
var current_layer_modulate_color


#settings
@export_category("Settings")
@export var flicker_rate = 1.0
@export var flicker = true
@export var white_only = false
@export var black_only = false


func _ready() -> void:
	#Set the flicker rate on the timer
	timer.wait_time = flicker_rate
	
	put_tiles_on_correct_layer()
	
	tile_set.set_physics_layer_collision_layer(Layer.White, 1)
	tile_set.set_physics_layer_collision_layer(Layer.Black, 1)
	if white_only:
		flicker = false
		tile_set.set_physics_layer_collision_layer(Layer.Black, 0)
		set_layer_modulate(Layer.Black, Color(255,255,255,0.075))
	if black_only:
		flicker = false
		tile_set.set_physics_layer_collision_layer(Layer.White, 0)
		set_layer_modulate(Layer.White, Color(255,255,255,0.075))
	
func _on_timer_timeout() -> void:
	if not flicker:
		return
	#print(tile_set.get_physics_layer_collision_layer(Layer.White))
	match current_layer:
		
		Layer.Black:
			# make the previous White layer transparent
			set_layer_modulate(previous_layer, Color(255,255,255,0.075))
			# make the current Black layer solid colored
			set_layer_modulate(current_layer, Color(255,255,255,1.0))
			
			# turn OFF previous white layer physics if NOT OFF already
			#turn_off_previous_layer_physics()
			if tile_set.get_physics_layer_collision_layer(Layer.White) == 1:
				tile_set.set_physics_layer_collision_layer(Layer.White, 0)

			# turn ON current layer physics if NOT ON already
			if tile_set.get_physics_layer_collision_layer(Layer.Black) == 0:
				tile_set.set_physics_layer_collision_layer(Layer.Black, 1)

			# turn ON current BLACK layer physics
			
			#set current layer to White for next iteration
			current_layer = Layer.White
			#set new previous layer to Black
			previous_layer = Layer.Black
			
		Layer.White:
			set_layer_modulate(previous_layer, Color(255,255,255,0.075))
			set_layer_modulate(current_layer, Color(255,255,255,1.0))
			
			#turn_off_previous_layer_physics()
			if tile_set.get_physics_layer_collision_layer(Layer.Black) == 1:
				tile_set.set_physics_layer_collision_layer(Layer.Black, 0)

			# turn ON current layer physics if NOT ON already
			if tile_set.get_physics_layer_collision_layer(Layer.White) == 0:
				tile_set.set_physics_layer_collision_layer(Layer.White, 1)

			
			#set current layer to Black for next iteration
			current_layer = Layer.Black
			#set new previous layer to White
			previous_layer = Layer.White
	#
##func turn_off_previous_layer_physics():
	##if tile_set.get_physics_layer_collision_layer(previous_layer) == 1:
				##tile_set.set_physics_layer_collision_layer(previous_layer, 0)
				##
##func turn_on_current_layer_physics():
	##if tile_set.get_physics_layer_collision_layer(current_layer) == 0:
				##tile_set.set_physics_layer_collision_layer(current_layer, 1)
func put_tiles_on_correct_layer():
	var main_level_layer = 2
	var all_used_tiles = get_used_cells(main_level_layer)
	for tile_coord in all_used_tiles:
		var tile = get_cell_tile_data(main_level_layer,tile_coord)
		#if black put on black layer
		if tile.get_custom_data("layer") == Layer.Black:
			set_cell(Layer.Black,tile_coord, 0, Vector2i(0,0))
			set_cell(main_level_layer,tile_coord,-1)
		elif tile.get_custom_data("layer") == Layer.White:
			set_cell(Layer.White,tile_coord, 0, Vector2i(1,0))
			set_cell(main_level_layer,tile_coord,-1)
		elif tile.get_custom_data("layer") == 2:
			print("found two tiles to go on non flicker layer")
	
