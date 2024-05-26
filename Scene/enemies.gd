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
	
		if abs(direzione.y) > abs(direzione.x) && direzione.y>0 :
			$AnimatedSprite2D.play("walk_down")
		
		elif abs(direzione.y) > abs(direzione.x) && direzione.y<0:
			$AnimatedSprite2D.play("walk_up")
		
		elif abs(direzione.y) < abs(direzione.x) && direzione.x>0:
			$AnimatedSprite2D.play("walk_left")
			$AnimatedSprite2D.flip_h=true
		
		elif abs(direzione.y) < abs(direzione.x) && direzione.x<0:
			$AnimatedSprite2D.play("walk_left")
			$AnimatedSprite2D.flip_h=false
	
		
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
	
		collision=true
		if abs(direzione.y) > abs(direzione.x) && direzione.y>0:
			$AnimatedSprite2D.play("attack_down")
		
		elif abs(direzione.y) > abs(direzione.x) && direzione.y<0:
			$AnimatedSprite2D.play("attack_up")
		
		elif abs(direzione.y) < abs(direzione.x) && direzione.x>0:
			$AnimatedSprite2D.play("attack_left")
			$AnimatedSprite2D.flip_h=true
		
		elif abs(direzione.y) < abs(direzione.x) && direzione.x<0:
			$AnimatedSprite2D.play("attack_left")
			$AnimatedSprite2D.flip_h=false
			
		direzione.x=0
		direzione.y=0

func _on_area_2d_body_exited(body):
	collision=false
