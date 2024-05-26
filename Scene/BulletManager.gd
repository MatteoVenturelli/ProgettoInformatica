extends Node2D

@export var bullet_scene: PackedScene

func _on_player_1_shoot(position, velocity):
	print("gianno frocio")
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.position=position
	bullet.direction=velocity.normalized()
	bullet.add_to_group("bullets")
