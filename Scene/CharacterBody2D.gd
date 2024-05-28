extends CharacterBody2D



func _physics_process(delta):
	#if position==Vector2.ZERO:
	queue_free()
	move_and_slide()
	
