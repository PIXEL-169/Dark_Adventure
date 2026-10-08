extends Node2D


var direction : int = 1
var is_dead : bool = false
var is_hurted : bool = false
var start_x := 1536.0
var patrol_distance: float = 150
@export var speed = 150


@onready var slime: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_box: HurtBox = $HurtBox

func _ready() -> void:
	start_x = position.x
	hurt_box.hurted.connect(_on_hurted)
	hurt_box.died.connect(_on_died)
	slime.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if is_dead or is_hurted:
		return
	position.x += direction * speed * delta
		
	if position.x >= start_x + patrol_distance:
		direction = -1
		slime.flip_h = true
	elif position.x <= start_x - patrol_distance:
		direction = 1
		slime.flip_h = false

func _on_hurted() -> void:
	if is_dead:
		return
	is_hurted = true
	slime.play("hurted")

func _on_died() -> void:
	is_dead = true
	slime.play("died")
	
func _on_animation_finished() -> void:
	if slime.animation == "hurted":
		is_hurted = false
		slime.play("moving")
	elif slime.animation == "died":
		queue_free()
