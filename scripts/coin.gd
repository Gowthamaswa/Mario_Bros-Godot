extends AnimatedSprite2D

func _ready():
	var coin_tween = get_tree().create_tween()
	coin_tween.tween_property(self, "position", position + Vector2(0, -40), .3)
	coin_tween.chain().tween_property(self, "position", position, .3)
	
	# tween_callback() to trigger any custom behavior you want to occur at that point during the animation.
	coin_tween.tween_callback(queue_free)
