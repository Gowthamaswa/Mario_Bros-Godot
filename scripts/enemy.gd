extends Area2D

class_name Enemy

@export var horizontal_speed = 20
@export var vertical_speed = 100
@export var direction = -1

@onready var ray_cast_2d_bottom = $RayCast2DBottom as RayCast2D
@onready var ray_cast_2d_left = $RayCast2DLeft as RayCast2D
@onready var ray_cast_2d_right = $RayCast2DRight as RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D


func _process(delta):
	if !ray_cast_2d_bottom.is_colliding():
		position.y += delta * vertical_speed


	if ray_cast_2d_left.is_colliding():
		direction = 1
	elif ray_cast_2d_right.is_colliding():
		direction = -1
	animated_sprite_2d.flip_h = true if direction == 1 else false
	position.x += direction * delta * horizontal_speed

func die():
	horizontal_speed = 0
	vertical_speed = 0
	animated_sprite_2d.play("dead")
