extends Node

#Vars
export var Selected_Enemy = ""

var Spawn_Number

var Cooldown = 0

var Spawn_Loc_X
var Spawn_Loc_Y
var Spawn_Variance_X
var Spawn_Variance_Y

var Random_Int

var EN

onready var Grey_Wolf = load("res://sprites/enemies/wolves/Grey_Wolf.png")
onready var Bee = load("res://sprites/enemies/Bees/Bee.png")
onready var Enemy_Ai = load("res://Test_Enemy.gd")

const Wolf_Instance = preload("res://Grey_wolf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _Enemy_Selection():
	Random_Int = rand_range(0, 1)
	Random_Int = round(Random_Int)
	if Random_Int == 0:
		Selected_Enemy = "Grey Wolf"
		EN = 0
	elif Random_Int == 1:
		Selected_Enemy = "Bee"
		EN = 1

func _Enemy_Info():
	if EN == 0:
		Spawn_Number = 10
		Spawn_Variance_X = 10
		Spawn_Variance_Y = 10
	elif EN == 1:
		Spawn_Number = 3
		Spawn_Variance_X = 30
		Spawn_Variance_Y = 30

func _Spawn_Enemy(): #This function is suppose to create a new enemy.
	if EN == 0:
		for i in range(3):
			var Grab_Instance = Wolf_Instance.instance()
			self.add_child(Grab_Instance)
		
		#var New_Grey_Wolf = KinematicBody2D.new()
		#New_Grey_Wolf.set_script(Enemy_Ai)
		#New_Grey_Wolf.Lower_DC_CD_Range = 100 #None of these var assigns are working.
		#New_Grey_Wolf.Upper_DC_CD_Range = 200
		#New_Grey_Wolf.Walk_Speed = 300
		#var My_Sprite = Sprite.New()
		#My_Sprite.Texture = Grey_Wolf
		#New_Grey_Wolf.add_child(My_Sprite)
	if EN == 1:
		pass

func _process(delta):
	if Cooldown == 0:
		if Selected_Enemy == "":
			_Enemy_Selection()
		_Enemy_Info()
		_Spawn_Enemy()
		Selected_Enemy == ""
		Cooldown = 1000
	else:
		Cooldown = Cooldown - 1
