extends CharacterBody2D


@export var speed = 250.0
@export_range(0, 1) var acceleration = 0.1 
@export_range(0, 1) var deceleration = 0.1

@export var jump_force = -400.0
@export_range(0, 1) var decelerate_on_jump_release = 0.5

var hit_frame_start: int = 1
var hit_frame_end: int = 6

var is_dead: bool = false
var attacking : bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: HitBox = $HitBox
@onready var hit_box_collision: CollisionShape2D = $HitBox/CollisionShape2D

func _ready() -> void:
	hit_box_collision.disabled = true
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
		
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release
		
	if Input.is_action_just_pressed("attack"):
		start_attack()

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if not attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	move_and_slide()


func start_attack() -> void:
	attacking = true
	animated_sprite.play("attack")

func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite == null:
		return
	if animated_sprite.animation != "attack":
		return
	var active := animated_sprite.frame >= hit_frame_start and animated_sprite.frame <= hit_frame_end
	hit_box_collision.set_deferred("disabled", not active)
	
func _on_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		attacking = false
		hit_box_collision.set_deferred("disabled", true)

func _on_hurt_box_died() -> void:
	is_dead = true
	animated_sprite.play("Dead")

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
