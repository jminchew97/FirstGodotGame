extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -100.0

@onready var coyote_timer: Timer = $CoyoteTimer

var can_jump = true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY
		
	# if player is not on floor start coyote timer
	if is_on_floor() == false:
		coyote_timer.start()
		
	if is_on_floor():
		can_jump = true
	#if Input.is_action_just_pressed("ui_accept") :
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_coyote_timer_timeout() -> void:
	can_jump = false
	print("cant jump")
	pass # Replace with function body.
