extends Node2D

@export var bullet_scene: PackedScene

func _on_player_1_shoot(position):
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.position=position
	
	
	if $"../Player1/Player".animation=="shoot_up":
		bullet.direction.x=0
		bullet.direction.y=-1
		bullet.position.y-=60
	elif $"../Player1/Player".animation=="shoot_down":
		bullet.direction.x=0
		bullet.direction.y=1
		bullet.position.y+=60
	elif $"../Player1/Player".animation=="shoot_left"&& $"../Player1/Player".flip_h==true:
		bullet.direction.x=1
		bullet.direction.y=0
		bullet.position.y+=20
		bullet.position.x+=60
	elif $"../Player1/Player".animation=="shoot_left"&& $"../Player1/Player".flip_h==false:
		bullet.direction.x=-1
		bullet.direction.y=0
		bullet.position.y+=20
		bullet.position.x-=60
		
		
	#bullet.direction=bullet.direction.normalized()
	bullet.add_to_group("bullets")
