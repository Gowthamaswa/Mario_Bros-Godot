extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PlayerMode{
	BIG,
	SMALL,
	SHOOTING
}  


#Refernces
@onready var animated_sprite_2d = $AnimatedSprite2D as PlayerAnimatedSprite
@onready var area_collision_shape = $Area2D/AreaCollisionShape
@onready var body_collision_shape=$BodyCollisionShape



@export_group("Locomotion")
@export var run_speed_damping = 0.5
@export var speed =  100
@export var jump_velocity = -350
@export_group("")

@export_group("stomping enemies")
@export var min_stomp_degree = 35
@export var mmax_stomp_degree = 140
@export var stomp_y_velocity = -150
@export_group("")

@export_group("camera sync")
@export var camera_sync: Camera2D
@export var should_camera_sync: bool = true 
@export var camera_speed: float = 0.1
@export_group("")

 	
var player_mode = PlayerMode.SMALL

func _physics_process(delta):
	
	#apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#control jump movements
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
		
	var direction = Input.get_axis("left","right")
	
	if direction:
		velocity.x = lerp(velocity.x, speed*direction,run_speed_damping*delta)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta) 
		
	animated_sprite_2d.trigger_animation(velocity, direction, player_mode)
		
	move_and_slide()
	
	if global_position.x > camera_sync.global_position.x && should_camera_sync:
		camera_sync.global_position.x = global_position.x
		
	
	


func _on_area_2d_area_entered(area):
	if area is Enemy:
		handle_enemy_collision(area)

func handle_enemy_collision(enemy: Enemy):
	if Enemy == null:
		return
		
	var angle_of_collision = rad_to_deg(position.angle_to_point(enemy.position))
	
	if angle_of_collision > min_stomp_degree && mmax_stomp_degree >angle_of_collision:
		enemy.die()
		on_enemy_stomped()
		
	else:
		die()
		
func on_enemy_stomped():
	velocity.y = stomp_y_velocity
		
		
func die():
	print("dead")
	
	






