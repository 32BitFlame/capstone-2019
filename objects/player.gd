extends KinematicBody2D

export (float) var walk_speed;
export (float) var sprint_speed;
export (float) var tired_speed;

export (int) var sprint_timer;
export (int) var sprint_timer_diff;

var sprint_timer_iter = 0;
var sprint_cooldown = true;

var move_speed = walk_speed;
var velocity = Vector2();
var move_vector_normalized = Vector2(0,0);

func _ready():
	pass

func weapon_fire():
	# Fire
	if Input.is_action_just_pressed("fire"):
		print_debug()

func _physics_process(delta):
	# Rotates to face player
	look_at(get_global_mouse_position());
	rotate(1.57079633);
	
	
	move_vector_normalized = Vector2(0,0);
	
	#Sprint: Checks if player is able to sprint and the key is pressed
	if Input.is_action_pressed("sprint") && sprint_timer_iter < sprint_timer && !sprint_cooldown:
		sprint_timer_iter+=sprint_timer_diff;
		if(sprint_timer_iter >= sprint_timer):
			sprint_cooldown = true;
		move_speed = sprint_speed;
	else:
		#Checks sprint timer to 'charge' sprint also checks if sprint is enabled
		move_speed = tired_speed if sprint_cooldown else walk_speed;
		if sprint_timer_iter > 0:
			sprint_timer_iter-=1;
		elif sprint_cooldown == true:
			sprint_cooldown = false;
	
	#Checks for button presses and sets movement vector accordingly
	move_vector_normalized.x += _castBoolToInt(Input.is_action_pressed("ui_right"));
	move_vector_normalized.x -= _castBoolToInt(Input.is_action_pressed("ui_left"));
	
	move_vector_normalized.y -= _castBoolToInt(Input.is_action_pressed("ui_up"));
	move_vector_normalized.y += _castBoolToInt(Input.is_action_pressed("ui_down"));
	
	#Moves and collides with movement vector with a magnitude of movement speed
	move_and_slide(move_vector_normalized * move_speed, Vector2(0,0));

func _castBoolToInt(boolVal):
	return 1 if boolVal else 0