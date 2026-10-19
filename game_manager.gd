extends Node

signal score_changed(value: int)

var score: int = 0

func _enter_tree() -> void:
	add_to_group("game_manager")

func add_points() -> void:
	score += 1
	score_changed.emit(score)
