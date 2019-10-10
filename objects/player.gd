extends KinematicBody2D

export (float) var walk_speed;
export (float) var sprint_speed;
export (float) var tired_speed;

var move_speed = walk_speed;
var velocity = Vector2();
var move_vector_normalized = Vector2(0,0);

export (int) var sprint_timer;
var sprint_timer_iter = 0;
export (int) var sprint_timer_diff;
var sprint_cooldown = true;
var net_iter = 0;
export (int) var net_iter_max;
func _ready():
	pass

func _physics_process(delta):
	move_vector_normalized = Vector2(0,0);
	
		
	if Input.is_action_pressed("sprint") && sprint_timer_iter < sprint_timer && !sprint_cooldown:
		sprint_timer_iter+=sprint_timer_diff;
		if(sprint_timer_iter >= sprint_timer):
			sprint_cooldown = true;
		move_speed = sprint_speed;
	else:
		move_speed = tired_speed if sprint_cooldown else walk_speed;
		if sprint_timer_iter > 0:
			sprint_timer_iter-=1;
		elif sprint_cooldown == true:
			sprint_cooldown = false;
		
	if Input.is_action_pressed("ui_right"):
		move_vector_normalized.x += 1;
	if Input.is_action_pressed("ui_left"):
		move_vector_normalized.x -= 1;
	if Input.is_action_pressed("ui_up"):
		move_vector_normalized.y -= 1;
	if Input.is_action_pressed("ui_down"):
		move_vector_normalized.y += 1;
	
	move_and_slide(move_vector_normalized * move_speed, Vector2(0,0));
	net_iter+=1;