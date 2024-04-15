extends Block

class_name MysteryBox

enum BonusType {
	COIN,
	SHROOM,
	FLOWER
}

const SROOM_SCENE = preload("res://scenes/shroom.tscn")

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var bonus_type: BonusType = BonusType.COIN
@export var invisible: bool = false

var is_empty = false

func _ready():
	animated_sprite_2d.visible = !invisible
	
func bump(player_mode: Player.PlayerMode):
	if is_empty:
		return
	
	if invisible:
		animated_sprite_2d.visibile = true
		invisible =!invisible
		
	super.bump(player_mode)
	make_empty()
	
	match bonus_type:
		BonusType.SHROOM:
			spawn_shroom()
	
func make_empty():
	is_empty = true
	animated_sprite_2d.play("empty")

func spawn_shroom():
	var shroom = SROOM_SCENE.instantiate()
	shroom.global_position = global_position
	get_tree().root.add_child(shroom)
