extends Area2D
class_name Coin


func _on_body_entered(_body: Node2D) -> void:
	var increase := get_tree().get_first_node_in_group("game_manager")
	if increase:
		increase.add_points()
	queue_free()
