extends KinematicBody2D

#establishes variables
export (int) var Walk_Speed
export (int) var Lower_DC_CD_Range
export (int) var Upper_DC_CD_Range

export (int) var Attack_Dmg
export (int) var Attack_Spd

export (int) var Hit_Points

export (bool) var ranged

var Volacity = Vector2()
var V_Normalized = Vector2()
var Direction_Change_CD = 0

var Player_Location = Vector2()
var Player

var Colliding = false
var Player_Detect = false

var SpriteNode

func _ready():
	Player = get_parent().get_node("Player")
	SpriteNode = get_node("Sprite")

#Enemy AI
func _physics_process(delta):
	#Determines how enemy will act in current situation.
	if Player_Detect == true:
		var Current_Rotation = self.rotation
		Player = self.get_parent().get_node("Player")
		Player_Location = Vector2()
		Player_Location = Player.get_position()
		self.look_at(Player_Location)
		Current_Rotation = self.rotation
		
		Volacity = Vector2()
		Volacity = Vector2(Walk_Speed, 0).rotated(Current_Rotation)
	elif !Colliding && Player_Detect == false:
		if Direction_Change_CD == 0:
			rotation = rand_range(0, 360)
			Direction_Change_CD = int(rand_range(Lower_DC_CD_Range, Upper_DC_CD_Range))
		
		Volacity = Vector2()
		Volacity = Vector2(Walk_Speed, 0).rotated(rotation)
		
		Direction_Change_CD -= 1
	elif Colliding:
		rotation += rand_range(90, 270)
		Direction_Change_CD = int(rand_range(Lower_DC_CD_Range, Upper_DC_CD_Range))
	
	Colliding = move_and_collide(Volacity * delta)

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	var strBody = str(body)
	var strBody_id = str(body_id)
	var strBody_shape = str(body_shape)
	var strArea_shape = str(area_shape)
	if strBody == "[KinematicBody2D:1228]":
		Player_Detect = true
		print(body)
		print(strBody_id)
		print(strBody_shape)
		print(strArea_shape)

func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	var strBody = str(body)
	if strBody == "[KinematicBody2D:1228]":
		print(body)
		Player_Detect = false
