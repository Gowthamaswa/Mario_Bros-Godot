extends Enemy

func die():
	super.die()
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	
	# to make disappear from game once player stomps the mushroom 
	get_tree().create_timer(1.5).timeout.connect(queue_free)
