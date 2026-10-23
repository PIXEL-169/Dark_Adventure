extends TextureProgressBar

@onready var health_bar: TextureProgressBar = %HealthBar


func setup_health(max_value: int, current: int) -> void:
	health_bar.max_value = max_value
	health_bar.value = current 

func update_health(current: int) -> void:
	var tween := create_tween()
	tween.tween_property(health_bar, "value", current, 0.2)
