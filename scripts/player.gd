extends CharacterBody2D


const SPEED = 180.0
const JUMP_VELOCITY = -320.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_collision: CollisionShape2D = $hitbox/hitboxCollision

var is_attacking: bool = false

func _ready() -> void:
	hitbox_collision.disabled = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()
	
	if not is_attacking:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis("move_left", "move_right")
		
		if direction > 0:
			animated_sprite.flip_h = false
			$hitbox.scale.x = 1
		elif direction < 0:
			animated_sprite.flip_h = true
			$hitbox.scale.x = -1
			
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x , 0, SPEED)
		
	move_and_slide()
	
func start_attack() -> void:
	is_attacking = true
	
	if animated_sprite.sprite_frames.has_animation("attack"):
		animated_sprite.play("attack")
		
	hitbox_collision.disabled = false
	
	if animated_sprite.sprite_frames.has_animation("attack"):
		await animated_sprite.animation_finished
	else:
		await get_tree().create.timer(0.3).timeout
	
	hitbox_collision.disabled = true
	is_attacking = false
