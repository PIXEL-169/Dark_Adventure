extends Area2D

@onready var pickup: AudioStreamPlayer2D = $pickup

func _ready() -> void:
	add_to_group("coins")

func _on_body_entered(body: Node2D) -> void:
	if body is not PLAYER:
		return
	set_deferred("monitoring", false)
	remove_from_group("coins")
	
	var increase := get_tree().get_first_node_in_group("game_manager")
	if increase:
		increase.add_points()
	hide()
	pickup.play()
	await pickup.finished
	queue_free()
