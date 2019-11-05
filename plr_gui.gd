extends MarginContainer
func _physics_process(delta):
	rect_position = Vector2(get_parent().get_node("Player").position.x - (get_viewport().size.x / 2), get_parent().get_node("Player").position.y - (get_viewport().size.y / 2))