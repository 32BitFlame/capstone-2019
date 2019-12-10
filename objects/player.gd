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

var healthbar;

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
		_name = "Starter"
	func fire_check():
		var fire_button = Input.is_action_just_pressed("fire")
		var mx = parent.get_global_mouse_position().x
		var my = parent.get_global_mouse_position().y
		if(fire_button && _fireIter == 0):
			var hit = self.bullet.instance()
			hit.StartMovement(parent.position.x, parent.position.y ,mx,my, parent);
			parent.get_parent().add_child(hit)
			_fireIter = 60
			print("fire")
		if(_fireIter > 0):
			_fireIter -= 1

class FusionRifle:
	extends Weapon
	var parent
	var chargetime = 30;
	var _charge_iter = chargetime;
	var rounds_per_burst = 50;
	var difference_per_round = 2;
	var _round_iter = 0;
	var _fireIter = 0;
	var mx = 0;
	var my = 0;
	var is_firing = false;
	var prev_frame_fire = false;
	var ready = false;
	func _init(_bullet_path, _parent).(_bullet_path):
		self.parent = _parent
		self.bullet = load(_bullet_path);
		_name = "Starter"
	func _ready():
		print(_charge_iter.type)
		print(chargetime.type)
		ready = true
	func _create_bullet():
		var hit = self.bullet.instance()
		hit.StartMovement(parent.position.x, parent.position.y ,mx,my, parent);
		parent.get_parent().add_child(hit)
	func fire_check():
		print("VIBE CHECK1")
		if(!ready):
			return
		var current_fire = Input.is_action_pressed("fire")
		var lifted_fire = Input.is_action_just_released("fire")
		print("VIBE CHECK")
		if(lifted_fire && !is_firing):
			_charge_iter = chargetime
			print("reset")
		if(current_fire && !is_firing):
			_charge_iter-=1
			print(_charge_iter)
			
		if(_charge_iter == 0):
			is_firing = true
			_charge_iter = chargetime
		if(is_firing):
			if(_fireIter == 0):
				#Fire
				print("fire")
#				_create_bullet()
				_fireIter = difference_per_round
			_fireIter-=1
			
		
		prev_frame_fire = current_fire;
		

class TestGun2:
	extends Weapon
	var parent
	var firerate = 2;
	var _fireIter = 0;
	var accuracy = 0.5;
	onready var lines = []
	var shootVectorx
	var shootVectory
	
	func _init(_bullet_path, _parent).(_bullet_path):
		self.parent = _parent
		self.bullet = load(_bullet_path);
		_name = "TestGun"
	func fire_check():
		var fire_button = Input.is_action_pressed("fire")
		var mx = parent.get_global_mouse_position().x
		var my = parent.get_global_mouse_position().y
		if(fire_button && _fireIter == 0):
			var hit = self.bullet.instance()
			var ox = parent.position.x
			var oy = parent.position.y
			var angle = rand_range(-accuracy,accuracy)
			print("angle: " + String(angle))
			var shootVectorx = ox + cos(angle) * (mx - ox) - sin(angle) * (my - oy)
			var shootVectory = oy + sin(angle) * (mx - ox) + cos(angle) * (my - oy)
			var shootVector = Vector2(shootVectorx, shootVectory)
			hit.StartMovement(parent.position.x, parent.position.y ,shootVector.x, shootVector.y, parent);
			parent.get_parent().add_child(hit)
			_fireIter = firerate
			
			
		if(_fireIter > 0):
			_fireIter -= 1
	
var actionSprites = {
	actionStates.none:load("res://sprites/Player_Assets/Player.png"),
	actionStates.melee:load("res://sprites/Player_Assets/Melee_attack.png"),
	actionStates.gun:load("res://sprites/Player_Assets/Base_Gun.png")
}
var starterGun = StarterGun.new("res://starterGun_bullet.tscn", self)
var testGun = TestGun2.new("res://starterGun_bullet.tscn", self)
var action_lock = 0;
var cur_action = actionStates.none
var sprite
export (int) var max_weapons
var weapon_slot = 0
var __weapons = [] #DO NOT SET DIRECTLY
var weapon_drop_scene = load("res://gunDrop.tscn")

func add_weapon(weapon):
	
	if __weapons.size() + 1 > max_weapons: #Checks if there is enough slots
		var _weapon = __weapons[weapon_slot]
		var weapon_drop = weapon_drop_scene.instance()
		get_tree().get_current_scene().add_child(weapon_drop)
		weapon_drop.start(position.x, position.y, _weapon)
		__weapons[weapon_slot] = weapon
		return
	__weapons.append(weapon)
	add_child(starterGun)

func _ready():
	add_weapon(starterGun)
	for child in get_children():
		if(child is Sprite):
			sprite = child #Gets child sprite object
			

func _physics_process(delta):
#	healthbar.value = health
	
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
	
	#Item pickup:
	if Input.is_action_just_pressed("get_weapon"):
		print("E")
		#print("mouse {mx}, {my}; self {x}, {y}".format({"mx":get_global_mouse_position().x, "my":get_global_mouse_position().y, "x":position.x, "y":position.y}))
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray( position, get_global_mouse_position())
		result.empty()
		if not result.empty():
			var obj = result.collider
			print("hit")
			if obj.has_method("get_weapon"):
				var _weapon = obj.get_weapon(self, null)
				add_weapon(_weapon);
				print(_weapon);
				
				
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
	
	if Input.is_action_just_pressed("ui_accept"): #Test: Spawns a weapon drop
		#Debug
		var weapon_drop = weapon_drop_scene.instance()
		var vectorPlace = Vector2(position.y, position.y) + Vector2(10,0).rotated(rotation)
		weapon_drop.start(position.x + 100, position.y, FusionRifle.new("res://starterGun_bullet.tscn", self))
		weapon_drop.set_name("weapon_drop")
		get_parent().add_child(weapon_drop)
		
	if Input.is_action_just_pressed("debug_damage1"):
		print("Damage");
		damage(3);
	#Checks for button presses and sets movement vector accordingly
	move_vector_normalized.x += _castBoolToInt(Input.is_action_pressed("ui_right"))
	move_vector_normalized.x -= _castBoolToInt(Input.is_action_pressed("ui_left"))
	
	move_vector_normalized.y -= _castBoolToInt(Input.is_action_pressed("ui_up"))
	move_vector_normalized.y += _castBoolToInt(Input.is_action_pressed("ui_down"))
	
	#Moves and collides with movement vector with a magnitude of movement speed
	move_and_slide(move_vector_normalized * move_speed)
	
	sprite.texture = actionSprites[cur_action]
	
	__weapons[weapon_slot].fire_check()

func _castBoolToInt(boolVal):
	return 1 if boolVal else 0

func _draw():
	if Input.is_action_pressed("get_weapon"):
		draw_line(position, get_global_mouse_position(), Color.red, 100000000000000000, true)
		
func damage(amount: float):
	print("Damage")
	health -= amount
	print(amount);
	print("Health" + String(health))
	if(health < 0.1): 
		emit_signal("gameover") # Emits gameover signal to be recieved by any listening objects
		print("Gameover")