extends Area2D
class_name Coin
@onready var pickup: AudioStreamPlayer2D = $pickup


func _on_body_entered(_body: Node2D) -> void:
	var increase := get_tree().get_first_node_in_group("game_manager")
	if increase:
		increase.add_points()
	hide()
	pickup.play()
	await pickup.finished
	queue_free()
