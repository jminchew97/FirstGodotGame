extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("die") # Replace with function body.
	get_tree().reload_current_scene()
