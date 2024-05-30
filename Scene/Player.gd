extends CharacterBody2D

signal shoot 
var can_shoot:bool
var shooting:bool
var lives : int 
var waves : int
var enemies : int
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.play("stand_down")
	position.x=640
	position.y=1051
	can_shoot=true
	shooting=false
	enemies = 10
	lives = 3
	waves = 1
	$Player/Camera2D/Hud/LivesLabel.text= "X " + str(lives)
	$Player/Camera2D/Hud/WavesLabel.text= "WAVE: " + str(waves)
	$Player/Camera2D/Hud/EnemiesLabel.text= "X " + str(enemies)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func enemy_hit_player():
	#if zombie gianno hitta ventu
		lives -= 1
		$Player/Camera2D/Hud/LivesLabel.text= "X " + str(lives)
func _process(delta):
	var velocity=Vector2();
	if Input.is_key_pressed(KEY_W)&& !shooting:
		velocity.y=-1;
	if Input.is_key_pressed(KEY_S)&& !shooting:
		velocity.y=1;
	if Input.is_key_pressed(KEY_A)&& !shooting:
		velocity.x=-1;
	if Input.is_key_pressed(KEY_D)&& !shooting:
		velocity.x=1;
	
	if Input.is_key_pressed(KEY_LEFT)&& can_shoot==true:
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_left")
		$Player.flip_h=false
		shoot.emit(position)
		can_shoot=false
		shooting=true 
		$Timer.start()
		$Timer2.start()
	elif Input.is_key_pressed(KEY_RIGHT)&& can_shoot==true:
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_left")
		$Player.flip_h=true	
		shoot.emit(position)
		can_shoot=false
		shooting=true 
		$Timer.start()
		$Timer2.start()
	elif Input.is_key_pressed(KEY_UP)&& can_shoot==true:
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_up")
		shoot.emit(position)
		can_shoot=false
		shooting=true 
		$Timer.start()
		$Timer2.start()
	elif Input.is_key_pressed(KEY_DOWN)&& can_shoot==true:
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_down")
		shoot.emit(position)
		can_shoot=false
		shooting=true 
		$Timer.start()
		$Timer2.start()
		
		
	
	position.x=clamp(position.x, -319, 3361)
	position.y=clamp(position.y, -242, 2479)
	var movement=velocity.normalized()*500*delta;
	self.move_and_collide(movement);
	if !shooting:
		self.update_animations(velocity)
	
func update_animations(velocity):
		if velocity.y==1:
			$Player.play("walk2")
		elif velocity.y==-1:
			$Player.play("walk1")
		elif velocity.x==-1:
			$Player.play("walk3")
			$Player.flip_h=false
		elif velocity.x==1:
			$Player.play("walk3")
			$Player.flip_h=true
			
			
			
		if velocity==Vector2() && $Player.animation=="walk2"||$Player.animation=="shoot_down" :
			$Player.play("stand_down")
		if velocity==Vector2() && $Player.animation=="walk1"||$Player.animation=="shoot_up":
			$Player.play("stand_up")
		if velocity==Vector2() && $Player.animation=="walk3"||$Player.animation=="shoot_left":
			$Player.play("stand_left")
		



func _on_timer_timeout():
	can_shoot=true


func _on_timer_2_timeout():
	shooting=false

