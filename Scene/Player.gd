extends CharacterBody2D

signal shoot 
var last_velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.play("stand_down")
	position.x=640
	position.y=1051


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity=Vector2();
	if Input.is_key_pressed(KEY_W):
		velocity.y=-1;
	if Input.is_key_pressed(KEY_S):
		velocity.y=1;
	if Input.is_key_pressed(KEY_A):
		velocity.x=-1;
	if Input.is_key_pressed(KEY_D):
		velocity.x=1;
	
	if Input.is_key_pressed(KEY_LEFT):
		shoot.emit(position, last_velocity)
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_left")
		$Player.flip_h=false
	elif Input.is_key_pressed(KEY_RIGHT):
		shoot.emit(position, last_velocity)
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_left")
		$Player.flip_h=true	
	elif Input.is_key_pressed(KEY_UP):
		shoot.emit(position, last_velocity)
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_up")
	elif Input.is_key_pressed(KEY_DOWN):
		shoot.emit(position, last_velocity)
		velocity.x=0
		velocity.y=0
		$Player.play("shoot_down")
		
		
		
	
	position.x=clamp(position.x, -319, 3361)
	position.y=clamp(position.y, -242, 2479)
	var movement=velocity.normalized()*500*delta;
	self.move_and_collide(movement);
	self.update_animations(velocity)
	last_velocity= velocity
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
			
			
			
		if velocity==Vector2() && $Player.animation=="walk2":
			$Player.play("stand_down")
		if velocity==Vector2() && $Player.animation=="walk1":
			$Player.play("stand_up")
		if velocity==Vector2() && $Player.animation=="walk3":
			$Player.play("stand_left")
		

