extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	if Input.is_key_pressed(KEY_R):
		print(position)
	
	position.x=clamp(position.x, -777, 2843)
	position.y=clamp(position.y, -536, 2038)
	var movement=velocity.normalized()*500*delta;
	self.move_and_collide(movement);
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
			
			
			
		if velocity==Vector2() && $Player.animation=="walk2":
			$Player.play("stand_down")
		if velocity==Vector2() && $Player.animation=="walk1":
			$Player.play("stand_up")
		if velocity==Vector2() && $Player.animation=="walk3":
			$Player.play("stand_left")
		
		
