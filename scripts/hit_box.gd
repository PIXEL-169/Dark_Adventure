extends Area2D
class_name HitBox

@export var damage: int = 8
@export var active : bool = true

func _ready() -> void:
	set_active(active)
	area_entered.connect(_on_area_entered)
	
func set_active(boolean: bool) -> void:
	for child in get_children():
		if child is not CollisionShape2D: continue
		
		child.set_deferred("disabled", not boolean)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.get_damage(damage)
