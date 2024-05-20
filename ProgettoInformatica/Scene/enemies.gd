extends CharacterBody2D

@onready var player = get_node("/root/Node/Player1")
var entrato : bool
var speed : int = 200
var direzione : Vector2
var centroMappa : Vector2
var distanza

func _ready():
	entrato=false
	centroMappa.x=954
	centroMappa.y=852
	distanza = centroMappa-position
	
	if abs(distanza.x) > abs(distanza.y):
		direzione.x=distanza.x
		direzione.y=0
	else:
		direzione.x=0
		direzione.y=distanza.y
func _physics_process(_delta):
	var collision
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
	if entrato:
		direzione=player.position-position
		if collision != null:
			print("bremer")
			if direzione.x>direzione.y:
				direzione.x=0
				direzione.y=player.position.y
			else:
				direzione.x=player.position.x
				direzione.y=0
		
	
	direzione=direzione.normalized()
	velocity=speed*direzione
	move_and_slide()


func _on_timer_timeout():
	entrato=true
