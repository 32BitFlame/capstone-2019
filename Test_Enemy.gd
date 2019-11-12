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

var Colliding = false
var Player_Detect = false

#Enemy AI
func _physics_process(delta):
	#Determines how enemy will act in current situation.
	if Player_Detect == true:
		Volacity = Vector2()
		
		self.look_at(Vector2())
		
		Volacity = Vector2(Walk_Speed, 0)
	elif !Colliding:
		if Direction_Change_CD == 0:
			rotation = rand_range(0, 360)
			Direction_Change_CD = int(rand_range(Lower_DC_CD_Range, Upper_DC_CD_Range))
		
		Volacity = Vector2()
		
		Volacity = Vector2(Walk_Speed, 0).rotated(rotation)
		
		Direction_Change_CD -= 1
	else:
		rotation += rand_range(90, 270)
		Direction_Change_CD = int(rand_range(Lower_DC_CD_Range, Upper_DC_CD_Range))
	
	Colliding = move_and_collide(Volacity * delta)

func Set_Angle(target_pos):
	pass

func _on_Area2D_body_entered(body):
	Player_Detect = true

func _on_Area2D_body_exited(body):
	Player_Detect = false
