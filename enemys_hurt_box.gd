extends Area2D
class_name EnemyHurtBox

signal hurted()
signal died()

@export var healthPoints:= 20

func get_damage(value: int):
	healthPoints -= value
	print(healthPoints)
	
	hurted.emit()
	
	if healthPoints <= 0:
		died.emit()
