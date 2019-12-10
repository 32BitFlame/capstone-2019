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
#const Bee_Instance = preload("res://Basic_Bee.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Enemy_Selection():
	Random_Int = rand_range(0, 2)
	if Random_Int < 1:
		Selected_Enemy = "Grey Wolf"
		EN = 0
	if Random_Int < 2 && Random_Int > 1:
		Selected_Enemy = "Bee"
		EN = 1

func Spawn_Enemy(): #This function is suppose to create a new enemy.
	var X_Spawn = rand_range(-2400, 1560)
	var Y_Spawn = rand_range(-2480, 1960)
	var X_Y_Pos = Vector2(X_Spawn, Y_Spawn)
	if EN == 0:
		for i in range(3):
			var Grab_Instance = Wolf_Instance.instance()
			self.add_child(Grab_Instance)
			Grab_Instance.set_global_position(X_Y_Pos)
	#if EN == 1:
		#for i in range(10):
			#var Grab_Instance = Bee_Instance.instance()
			#self.add_child(Grab_Instance)
			#Grab_Instance.set_global_position(X_Y_Pos)

func _process(delta):
	if Cooldown == 0:
		if Selected_Enemy == "":
			Enemy_Selection()
		Spawn_Enemy()
		Selected_Enemy == ""
		Cooldown = 100
	else:
		Cooldown = Cooldown - 1
	Selected_Enemy = ""