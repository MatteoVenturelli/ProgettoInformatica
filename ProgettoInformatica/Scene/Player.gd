extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.position);
	self.position.x=100;


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
		
	var movement=velocity.normalized()*300*delta;
	self.move_and_collide(movement);
