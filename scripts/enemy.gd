extends Area2D

class_name Enemy

@export var horizontal_speed = 20
@export var vertical_speed = 100
@export var direction = -1

@onready var ray_cast_2d_bottom = $RayCast2DBottom as RayCast2D
@onready var ray_cast_2d_left = $RayCast2DLeft as RayCast2D
@onready var ray_cast_2d_right = $RayCast2DRight as RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D as AnimatedSprite2D
@onready var POINTS_LABEL_SCENE= preload("res://scenes/points_label.tscn")

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
	
func die_from_hit():
	set_collision_layer_value(3, false)
	set_collision_mask_value(3, false)
	
	rotation_degrees = 180
	horizontal_speed = 0
	vertical_speed = 0
	
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(self, "position",position + Vector2(0, -25), .3)
	die_tween.chain().tween_property(self, "position", position + Vector2(0 , 400), 4)
	
	var points_label = POINTS_LABEL_SCENE.instantiate()
	points_label.position = self.position + Vector2(-20, -20)
	get_tree().root.add_child(points_label) 

func _on_area_entered(area):
	if area is Turtle and (area as Turtle).in_a_shell and (area as Turtle).horizontal_speed != 0:
		die_from_hit()
