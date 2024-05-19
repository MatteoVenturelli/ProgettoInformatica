extends Node2D


@onready var main = get_node("/root/Node")
var enemies_scene:= preload("res://Scene/enemies.tscn")
var spawnPoints := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawnPoints.append(i)






func _on_timer_timeout():
	var spawn = spawnPoints[randi()%spawnPoints.size()]
	var enemy = enemies_scene.instantiate()
	enemy.position=spawn.position
	main.add_child(enemy)
