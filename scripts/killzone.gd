extends Area2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_collision: CollisionShape2D = $hitbox/hitboxCollision

func _on_body_entered(body: Node2D) -> void:
	func _die():
	timer.start()
	play_animation("Dead")
	print("You Died!")


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
