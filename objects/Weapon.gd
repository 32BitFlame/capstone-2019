extends Area2D
class_name Weapon # Abstract Do not Instantiate

var bullet;
var sprite;
var plr_sprite;
var drop_sprite;
var drop_rotation;
func _init(bullet_path): #DO not call
	bullet = load(bullet_path) # Just dont

func drop(x,y):
	
func fire(x,y):
	pass
