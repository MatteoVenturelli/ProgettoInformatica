extends Area2D

var direction:Vector2
var speed:int=300
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedBullet2D.play("bullet_down")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+= speed*direction*delta
