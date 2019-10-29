extends KinematicBody2D
signal gameover
onready var meleeHitbox = preload("res://Melee_Hitbox.tscn")

onready var meleeSprite = load("res://sprites/Player_Assets/Melee_attack.png")
onready var gunSprite = load("res://sprites/Player_Assets/Base_Gun.png")

export (float) var walk_speed;
export (float) var sprint_speed;
export (float) var tired_speed;

export (int) var sprint_timer;
export (int) var sprint_timer_diff;

var sprint_timer_iter = 0;
var sprint_cooldown = true;

export (float) var max_health;
var health = max_health;

var move_speed = walk_speed;
var move_vector_normalized = Vector2(0,0);

export (int) var melee_timer;
export (float) var melee_distance;

enum actionStates {
  none,
  melee,
  gun
}
class StarterGun:
	extends Weapon
	var parent
	var firerate = 30;
	var _fireIter = 0;
	func _init(_bullet_path, _parent).(_bullet_path):
		self.parent = _parent
		self.bullet = load(_bullet_path);
	func _physics_process(delta):
		var fire_button = Input.is_action_just_pressed("fire")
		var mx = get_global_mouse_position().x
		var my = get_global_mouse_position().y
		if(fire_button && _fireIter == 0):
			var hit = self.bullet.instance()
			hit.StartMovement(parent.position.x, parent.position.y ,mx,my);
			parent.get_parent().add_child(hit)
			print(String(mx) + ", " + String(my))
			
		if(_fireIter > 0):
			_fireIter -= 1

var actionSprites = {
	actionStates.none:load("res://sprites/Player_Assets/Player.png"),
	actionStates.melee:load("res://sprites/Player_Assets/Melee_attack.png"),
	actionStates.gun:load("res://sprites/Player_Assets/Base_Gun.png")
}
var starterGun = StarterGun.new("res://starterGun_bullet.tscn", self)
var action_lock = 0;
var cur_action = actionStates.none
var sprite
export (int) var max_weapons
var weapon_slot = 0
var __weapons = [] #DO NOT SET DIRECTLY
func add_weapon(weapon):
	if len(__weapons)+1 > max_weapons:
		__weapons[weapon_slot] = weapon
		#Drop Weapon (WIP)
		
		return
	__weapons += weapon
	


func _ready():
	__weapons += starterGun;
	for child in get_children():
		if(child is Sprite):
			sprite = child #Gets child sprite object

func _physics_process(delta):
	# Rotates to face player
	look_at(get_global_mouse_position());
	rotate(1.57079633); # Rotates 1.57 degrees
	
	if(action_lock != 0):
		action_lock -= 1
	else:
		cur_action = actionStates.none
		
	if(Input.is_action_just_pressed("melee") && action_lock == 0):
		var hit = meleeHitbox.instance()
		hit.position = Vector2(self.position.x, self.position.y) +  (Vector2(0,-melee_distance).rotated(rotation))
		hit.rotation = rotation
		hit.origin_obj = self # Avoid hitting self
		get_parent().add_child(hit)
		action_lock = melee_timer
		cur_action = actionStates.melee
		
	
	move_vector_normalized = Vector2(0,0);
	
	#Sprint: Checks if player is able to sprint and the key is pressed
	if Input.is_action_pressed("sprint") && sprint_timer_iter < sprint_timer && !sprint_cooldown:
		sprint_timer_iter+=sprint_timer_diff;
		if(sprint_timer_iter >= sprint_timer):
			sprint_cooldown = true;
		move_speed = sprint_speed;
	else:
		#Checks sprint timer to 'charge' sprint also checks if sprint is enabled
		move_speed = tired_speed if sprint_cooldown else walk_speed
		if sprint_timer_iter > 0:
			sprint_timer_iter-=1
		elif sprint_cooldown == true:
			sprint_cooldown = false
	
	#Checks for button presses and sets movement vector accordingly
	move_vector_normalized.x += _castBoolToInt(Input.is_action_pressed("ui_right"))
	move_vector_normalized.x -= _castBoolToInt(Input.is_action_pressed("ui_left"))
	
	move_vector_normalized.y -= _castBoolToInt(Input.is_action_pressed("ui_up"))
	move_vector_normalized.y += _castBoolToInt(Input.is_action_pressed("ui_down"))
	
	#Moves and collides with movement vector with a magnitude of movement speed
	move_and_slide(move_vector_normalized * move_speed, Vector2(0,0))
	
	sprite.texture = actionSprites[cur_action]
	

func _castBoolToInt(boolVal):
	return 1 if boolVal else 0

func damage(amount: float):
	health -= amount
	print(amount);
	if(health < 0.1): 
		emit_signal("gameover") # Emits gameover signal to be recieved by any listening objects