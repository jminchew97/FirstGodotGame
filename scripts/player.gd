extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -100.0
@export var ACCELERATION = 0.50
@export var FRICTION = 0.1
@onready var coyote_timer: Timer = $CoyoteTimer




var can_jump = false
func _physics_process(delta: float) -> void:
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


func _on_coyote_timer_timeout() -> void:

	pass # Replace with function body.
