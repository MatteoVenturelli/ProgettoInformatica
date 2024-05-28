extends Area2D
@onready var player = get_node("/root/Node/Player1/Player")
@onready var enemy = get_node("/root/Enemies")
var direction:Vector2
var speed:int=1100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.animation=="shoot_up":
		$AnimatedBullet2D.play("bullet_up")
	elif player.animation=="shoot_down":
		$AnimatedBullet2D.play("bullet_down")
	elif player.animation=="shoot_left"&& player.flip_h==false:
		$AnimatedBullet2D.play("bullet_left")
		$AnimatedBullet2D.flip_h=false
	elif player.animation=="shoot_left"&& player.flip_h==true:
		$AnimatedBullet2D.play("bullet_left")
		$AnimatedBullet2D.flip_h=true
		
		
	position+= speed*direction*delta


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	queue_free()

