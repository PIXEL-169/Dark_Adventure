extends Control


@onready var health_bar: TextureProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var coin_counter: Label = %CoinCounter

func _ready() -> void:
	var increase := get_tree().get_first_node_in_group("game_manager")
	if increase:
		increase.score_changed.connect(_on_score_changed)
		_on_score_changed(increase.score)
		
func _on_score_changed(value: int) -> void:
	coin_counter.text = str(value)
	
