extends Node2D
const speed = 20;
var velocityVector;
var started = false;
var damage = 3;
var parent;
func StartMovement(x,y,tx, ty, _parent):
	parent = _parent;
	self.position = Vector2(x,y);
	self.rotation = parent.rotation;
	velocityVector = Vector2(x - tx,y -ty);
	velocityVector = velocityVector.normalized() * -speed;
	started = true

func _physics_process(delta):
	if(!started):
		return
	self.translate(velocityVector)

func _on_Area2D_body_entered(body):
	if(!started):
		return
	if(body == parent):
		print(parent)
		return;
	else:
		if(body.has_method("damage") && body):
			body.damage(damage);
