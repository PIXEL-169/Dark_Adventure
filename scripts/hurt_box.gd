extends Area2D
class_name HurtBox

signal hurted()
signal died()
signal health_changed(current: int)

@export var healthPoints: int = 100
var is_dead := false

func get_damage(value: int) -> void:
	if is_dead:
		return

	healthPoints = max(healthPoints - value, 0)
	health_changed.emit(healthPoints)
	print(healthPoints)
	
	if healthPoints <= 0:
		is_dead = true
		set_deferred("monitorable", false)
		died.emit()
	else:
		hurted.emit()
