extends CharacterBody2D

@onready var tile_map: TileMap = $"../TileMap"
@onready var area_2d: Area2D = $Area2D

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -100.0
@export var ACCELERATION = 0.50
@export var FRICTION = 0.1
@onready var coyote_timer: Timer = $CoyoteTimer

var is_alive = true


var can_jump = false

func _process(delta: float) -> void:
	pass
	#get player position
	
	#print(tile_map.local_to_map(global_position))
	#tile_map.get_cell
func _physics_process(delta: float) -> void:
	player_movement(delta)
	
	
func player_movement(delta):
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		can_jump = true	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() || !coyote_timer.is_stopped()) and can_jump:
		velocity.y = JUMP_VELOCITY
		can_jump = false
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		#velocity.x = direction * SPEED
		
		#trying lerping
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
	else:

		velocity.x = lerp(velocity.x, 0.0, FRICTION)
	
	var was_on_floor = is_on_floor()
	move_and_slide()	
	
	if was_on_floor and !is_on_floor():
		coyote_timer.start()


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
#	if a tilemap is inside the area 2d
	if body is TileMap and is_alive:
		print("you died")
		is_alive = false
		get_tree().reload_current_scene()
