extends CharacterBody2D

const bulletPath=preload("res://Scene/bullet.tscn")
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
		
	var movement=velocity.normalized()*500*delta;
	self.move_and_collide(movement);
	if Input.is_key_pressed(KEY_R):
		shoot()
	
	
	


func shoot():
	var bullet=bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position=$Position2D.global_position
