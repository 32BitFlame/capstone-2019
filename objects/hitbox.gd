extends Node2D
class_name Hitbox
export (int) var lifetime_frames;
export (float) var damage;
var _iter = lifetime_frames;

var origin_obj;
func _physics_process(delta):
	if(_iter < 1):
		get_parent().remove_child(self)
	_iter-=1;

func _on_Area2D_body_entered(body):
	if(body.has_method("damage") && body != origin_obj): # Checks if method exists on object and that the object is not the node of origin
		body.damage(damage) # TODO: check
