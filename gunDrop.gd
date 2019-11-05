extends StaticBody2D

var weapon
func start(_x,_y, _weapon):
	print("-------------")
	print(_x)
	print(_y)
	print("------------")
	position = Vector2(_x, _y)
	weapon = _weapon

func get_weapon(sender, replacement):
	print("Name:  " + weapon._name)
	if(replacement == null):
		get_parent().remove_child(self)
		return weapon
	weapon = replacement
	