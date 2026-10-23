extends Control

@onready var health_bar: TextureProgressBar = %HealthBar
@onready var coin_counter: Label = %CoinCounter

@export var max_health = 100
@export var active := true

func _ready() -> void:
	set_active(active)
	var increase := get_tree().get_first_node_in_group("game_manager")
	if increase:
		increase.score_changed.connect(_on_score_changed)
		_on_score_changed(increase.score)
		
func setup_health(max_value: int, current: int) -> void:
	health_bar.max_value = max_value
	health_bar.value = current 

func update_health(current: int) -> void:
	var tween := create_tween()
	tween.tween_property(health_bar, "value", current, 0.2)

func _on_score_changed(value: int) -> void:
	coin_counter.text = str(value)
	
