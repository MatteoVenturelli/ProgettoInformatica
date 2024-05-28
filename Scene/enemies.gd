extends CharacterBody2D

@onready var player = get_node("/root/Node/Player1")
@onready var bullet = get_node("/root/bullet")
var alive: bool
var entrato : bool
var speed : int = 220
var direzione : Vector2
var centroMappa : Vector2
var distanza
var vecchiaPosizione: Vector2
var tolleranza := Vector2(3,3)
var tolleranza2 := Vector2(7,7)
var collision:bool
var bloccato:bool
func _ready():
	$AnimatedSprite2D.play("walk_down")
	$AnimatedSprite2D.frame=0
	entrato=false
	alive = true
	collision==false
	bloccato=false
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
	
	if entrato && !collision && alive && !bloccato:
		direzione=player.position-position
	if entrato && !collision && alive:
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
	if $AnimatedSprite2D.animation=="death_down" && $AnimatedSprite2D.frame==6:
		queue_free()
	elif $AnimatedSprite2D.animation=="death_up" && $AnimatedSprite2D.frame==6:
		queue_free()
	elif $AnimatedSprite2D.animation=="death_left" && $AnimatedSprite2D.frame==6:
		queue_free()
		
	direzione=direzione.normalized()
	velocity=speed*direzione
	move_and_slide()
func _on_timer_timeout():
	entrato=true
	#if player.position<vecchiaPosizione+tolleranza && player.position>vecchiaPosizione-tolleranza:
		#$AnimatedSprite2D.stop()
	#else:
		#$AnimatedSprite2D.play("walk_down")


func _on_area_2d_body_entered(body):
	collision=true
	if body==player:
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


func _on_area_2d_area_entered(area):
	alive=false
	if abs(direzione.y) > abs(direzione.x) && direzione.y>0:
		$AnimatedSprite2D.play("death_down")	
	elif abs(direzione.y) > abs(direzione.x) && direzione.y<0:
		$AnimatedSprite2D.play("death_up")	
	elif abs(direzione.y) < abs(direzione.x) && direzione.x>0:
		$AnimatedSprite2D.play("death_left")
		$AnimatedSprite2D.flip_h=true
	elif abs(direzione.y) < abs(direzione.x) && direzione.x<0:
		$AnimatedSprite2D.play("death_left")
		$AnimatedSprite2D.flip_h=false
	direzione.x=0
	direzione.y=0
	


func _on_timer_2_timeout():
	if position<=vecchiaPosizione+tolleranza2 && position>=vecchiaPosizione-tolleranza2 && !collision:
		bloccato=true
		if abs(direzione.y) > abs(direzione.x) && direzione.y>0:
			direzione.y-=30
			direzione.x=4000
		if abs(direzione.y) > abs(direzione.x) && direzione.y<0:
			direzione.y+=30
			direzione.x=4000
		if abs(direzione.y) < abs(direzione.x) && direzione.x>0:
			direzione.x-=30
			direzione.y=-4000
		if abs(direzione.y) < abs(direzione.x) && direzione.x<0:
			direzione.x+=30
			direzione.y=-4000
	vecchiaPosizione=position


func _on_timer_3_timeout():
	bloccato=false
