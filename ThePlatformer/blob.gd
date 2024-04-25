extends CharacterBody2D


@export var SPEED = 300.0

var jump = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var respawnpos = [0, 70]
var direction = 1	

func respawn():
	position.x = respawnpos[0]
	position.y = respawnpos[1]

func _physics_process(delta):
		
	if "Spikes:<TileMap#" in str($Area2D.get_overlapping_bodies()):
		visible = 0
	
	if is_on_wall:
		direction = -direction
	velocity.x = SPEED * direction
		
	move_and_slide()
