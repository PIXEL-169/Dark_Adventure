extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_hurt_box_died() -> void:
	animated_sprite.play("died")


func _on_hurt_box_hurted() -> void:
	animated_sprite.play("hurt")
