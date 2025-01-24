extends Node


# Called when the node enters the scene tree for the first time.
func go_to_next_level():
	var current_level:int = get_current_level_number()
	current_level += 1
	#var string = "I have %s cats." % "3"
	get_tree().change_scene_to_file("res://scenes/levels/level_%s.tscn" % current_level)

func get_current_level_number() -> int:
	# Gets current scene path with name  ex. res://scenes/levels/level_13.tscn
	var res_path = get_tree().current_scene.scene_file_path
	
	# gets only digits from string and converts to integar, ignores all non digits
	return res_path.to_int()
	
func _ready() -> void:
	get_current_level_number()
