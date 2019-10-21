extends Node2D
class_name Weapon # Abstract Do not Instantiate

var bullet;
var sprite;
func _init(bullet_path): #DO not call
	bullet = load(bullet_path) # Just dont

func fire(x,y):
	pass
