extends Area2D


@onready var level_manager: Node = $"../LevelManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	if body.name == "Player":
		next_level()
	#Engine.time_scale = lerp(Engine.time_scale,0.25,0.25)
	

func next_level():
	level_manager.go_to_next_level()
