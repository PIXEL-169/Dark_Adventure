extends Area2D
class_name EnemyHitBox

@export var damage: int = 20


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.get_damage(damage)
