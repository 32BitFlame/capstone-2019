extends MarginContainer
onready var plr = get_parent().get_node("Player");
func _physics_process(delta):
	rect_position = Vector2(plr.position.x - (get_viewport().size.x / 2), plr.position.y - (get_viewport().size.y / 2))
	$Healthbar.set_value(plr.health);