extends Area2D
class_name Coin

@onready var game_manager: Node = %GameManager


func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_points()
	queue_free()
