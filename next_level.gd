extends Area2D

@onready var massage: Label = $Massage

func _ready() -> void:
	massage.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is not PLAYER:
		return
		
	var coins_left = get_tree().get_nodes_in_group("coins").size()
	var slimes_left = get_tree().get_nodes_in_group("slimes").size()
	
	if coins_left > 0 or slimes_left > 0:
		show_massage("You have to finish the level first")
		return
		
	set_deferred("monitoring", false)
		
	var current_scene = get_tree().current_scene.scene_file_path
	var next_level_no = current_scene.to_int() + 1
	
	var next_level_path = "res://level_" + str(next_level_no) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
		
func show_massage(text: String) -> void:
	massage.text = text
	massage.show()
	await get_tree().create_timer(2.0).timeout
	massage.hide()
