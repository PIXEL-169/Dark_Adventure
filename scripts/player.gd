extends CharacterBody2D


@export var speed = 250.0
@export_range(0, 1) var acceleration = 0.1 
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -400.0
@export_range(0, 1) var decelerate_on_jump_release = 0.5

var is_dead: bool = false
var attacking : bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: HitBox = $HitBox



func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
		
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release
		
	if Input.is_action_pressed("attack"):
		attacking = true

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if attacking == true:
		animated_sprite.play("attack")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	move_and_slide()


func _on_hurt_box_died() -> void:
	animated_sprite.play("Dead")


func _on_animated_sprite_2d_frame_changed() -> void:
	if not animated_sprite: return
	
	var attackAnimation = animated_sprite.animation == "attack"
	var frame = animated_sprite.frame
	
	if attackAnimation:
		if frame == 3:
			hit_box.set_active(true)
		elif frame == 5:
			hit_box.set_active(false)
