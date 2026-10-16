extends Area2D
class_name HurtBox

signal hurted()
signal died()

@export var healthPoints: int = 100
var is_dead := false

func get_damage(value: int) -> void:
	if is_dead:
		return

	healthPoints -= value
	print(healthPoints)
	
	if healthPoints <= 0:
		is_dead = true
		set_deferred("monitorable", false)
		died.emit()
	else:
		hurted.emit()
