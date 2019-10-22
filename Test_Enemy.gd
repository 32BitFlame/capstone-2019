extends KinematicBody2D

#establishes variables
export (int) var Walk_Speed = 300

var Direction_Change_CD = 0

#Wolf AI
#func _Wolf_Ai(delta):
	#Determines how wolf will act in current situation.
	#if Direction_Change_CD = 0:
		