extends Area2D
class_name HurtBox

signal hurted()
signal died()

@export var healthPoints: int = 100

func get_damage(value: int):
	healthPoints -= value
	print(healthPoints)
	
	hurted.emit()
	
	if healthPoints == 0:
		died.emit()
