extends KinematicBody2D

#https://docs.godotengine.org/en/stable/tutorials/physics/kinematic_character_2d.html

const GRAVITY = 1000.0
const JUMP_FORCE = 500

export var speed = 5

var player_input = Vector2()
var velocity = Vector2()

var player_direction = 1

# COMPONENTS
onready var sprite_animator = $AnimatedSprite

func process_movement_input():
	if Input.is_action_pressed("player_left"):
		player_direction = -1
		player_input.x = -1
	elif Input.is_action_pressed("player_right"):
		player_input.x = 1
		player_direction = 1
	else:
		player_input.x = 0
	if Input.is_action_just_pressed("player_jump"):
		player_input.y = 1
	else:
		player_input.y = 0

func update_animation():
	sprite_animator.scale.x = player_direction
	if !is_on_floor():
		if velocity.y < 0:
			sprite_animator.animation = "jump_up"
		else:
			sprite_animator.animation = "jump_down"
		
	else:
		if abs(velocity.x) <= 30:
			sprite_animator.animation = "idle"
		else:
			sprite_animator.animation = "run"

func _physics_process(delta):
	process_movement_input()
	update_animation()
	
	# APPLY GRAVITY
	velocity.y += delta * GRAVITY
	
	if player_input.x == 0:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0, 0.3)
		else:
			velocity.x = lerp(velocity.x, 0, 0.05)
	else:
		velocity.x = player_input.x * speed
	
	if player_input.y == 1 and is_on_floor():
		velocity.y = -JUMP_FORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
