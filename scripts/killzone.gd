extends Area2D

@onready var timer: Timer = $Timer

var is_dead: bool = false

func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	if body.is_in_group("player") or body.name == "Player":
		is_dead = true
		print("You Died")
		
		body.set_physics_process(false)
		
		if body.has_node("AnimatedSprite2D"):
			var player_sprite: AnimatedSprite2D = body.get_node("AnimatedSprite2D")
			
			if player_sprite.sprite_frames.has_animation("Dead"):
				player_sprite.play("Dead")
			elif player_sprite.sprite_frames.has_animation("Dead"):
				player_sprite.play("Dead")
				
		Engine.time_scale = 0.5
		
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
