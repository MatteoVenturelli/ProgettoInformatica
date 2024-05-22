extends CharacterBody2D

@onready var player = get_node("/root/Node/Player1")
var entrato : bool
var speed : int = 220
var direzione : Vector2
var centroMappa : Vector2
var distanza
var vecchiaPosizione: Vector2
var tolleranza := Vector2(3,3)
var collision:bool
func _ready():
	$AnimatedSprite2D.play("walk_down")
	entrato=false
	collision==false
	centroMappa.x=954
	centroMappa.y=852
	distanza = centroMappa-position
	
	if abs(distanza.x) > abs(distanza.y):
		direzione.x=distanza.x
		direzione.y=0
	else:
		direzione.x=0
		direzione.y=distanza.y
func _physics_process(delta):
	if entrato && !collision:
		direzione=player.position-position
	
	if player.position<position+tolleranza && player.position>position-tolleranza && !collision:
		direzione.x=0
		direzione.y=0
	
		
	direzione=direzione.normalized()
	velocity=speed*direzione
	move_and_slide()
	vecchiaPosizione=player.position


func _on_timer_timeout():
	entrato=true
	#if player.position<vecchiaPosizione+tolleranza && player.position>vecchiaPosizione-tolleranza:
		#$AnimatedSprite2D.stop()
	#else:
		#$AnimatedSprite2D.play("walk_down")


func _on_area_2d_body_entered(body):
	pass



func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body!=$"." && body!=player:
		collision=true
		if abs(direzione.x)>abs(direzione.y):
			direzione.x=0
			#if direzione.x>0:
				#direzione.x=-player.position.x
			#else:
				#direzione.x=player.position.x
		else:
			direzione.y=0
			#if direzione.y>0:
			#	direzione.y=-player.position.y
			#else:
			#	direzione.y=player.position.y


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body!=$"." && body!=player:
		collision=false
