extends Enemy

var in_a_shell = false

const TURTLE_SHELL_COLLISION_SHAPE_POSITION = Vector2(0,5)
const TURTLE_FULL_COLLISION_SHAPE = preload("res://Resources/CollisionShapes/turtle_full_collision_shape.tres")
const TURTLE_SHELL_COLLISION_SHAPE = preload("res://Resources/CollisionShapes/turtle_shell_collision_shape.tres")
@onready var collision_shape_2d = $CollisionShape2D


func _ready():
	collision_shape_2d.shape = TURTLE_FULL_COLLISION_SHAPE

func die():
	if !in_a_shell:
		super.die()
		
	collision_shape_2d.set_deferred("shape", TURTLE_FULL_COLLISION_SHAPE)
	collision_shape_2d.set_deferred("position", TURTLE_SHELL_COLLISION_SHAPE_POSITION)
	in_a_shell = true
