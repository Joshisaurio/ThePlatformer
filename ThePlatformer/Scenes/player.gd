extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var VERTICAL_WALLJUMP_VELOCITY = -450
@export var HORIZONTAL_WALLJUMP_VELOCITY = 450
@export var ACCELERATION = 0.2
@export var SLOWDOWN = 0.3

var jump = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var respawnpos = [0, 70]

func respawn():
	position.x = respawnpos[0]
	position.y = respawnpos[1]

func _physics_process(delta):
		
	if "Spikes:<TileMap#" in str($Area2D.get_overlapping_bodies()):
		respawn()
	
	if is_on_floor():
		jump = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			jump = 1
	elif is_on_wall() and Input.is_action_just_pressed("jump"):
		if velocity.x > 0:
			velocity.x = -HORIZONTAL_WALLJUMP_VELOCITY
		else:
			velocity.x = HORIZONTAL_WALLJUMP_VELOCITY
		velocity.y = VERTICAL_WALLJUMP_VELOCITY
	elif jump == 1 and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		jump = 2
	else:
		velocity.y += gravity * delta
			
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerpf(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = lerpf(velocity.x, 0, SLOWDOWN)
		
	move_and_slide()
