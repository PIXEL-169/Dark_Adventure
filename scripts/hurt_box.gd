extends Area2D
class_name HurtBox

signal hurted()
signal died()
signal health_changed(current: int)

@export var healthPoints: int = 100
var is_dead := false

@onready var hurtsound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func get_damage(value: int) -> void:
	if is_dead:
		return
	
	if hurtsound:
		hurtsound.play()

	healthPoints = max(healthPoints - value, 0)
	health_changed.emit(healthPoints)
	
	if healthPoints <= 0:
		is_dead = true
		set_deferred("monitorable", false)
		died.emit()
	else:
		hurted.emit()
