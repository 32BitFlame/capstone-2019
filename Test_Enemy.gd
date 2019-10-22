extends KinematicBody2D

#establishes variables
export (int) var Walk_Speed = 200

var Volacity = Vector2()
var V_Normalized = Vector2()
var Direction_Change_CD = 0

#Wolf AI
func _physics_process(delta):
	#Determines how wolf will act in current situation.
	if Direction_Change_CD == 0:
		rotation = rand_range(0, 360)
		Direction_Change_CD = int(rand_range(20, 120))
	
	Volacity = Vector2()
	
	Volacity = Vector2(Walk_Speed, 0).rotated(rotation)
	
	Direction_Change_CD -= 1
	
	move_and_slide(Volacity)