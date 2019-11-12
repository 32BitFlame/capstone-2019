extends KinematicBody2D
const speed = 500;
var velocityVector;
var started = false;
var damage = 3;
func StartMovement(x,y,tx, ty):
	started = true
	self.position = Vector2(x,y);
	velocityVector = Vector2(x - tx,y -ty);
	velocityVector = velocityVector.normalized() * -speed;

func _physics_process(delta):
	if(!started):
		return
	move_and_collide(velocityVector)

func _on_Area2D_body_entered(body):
	if(body.has_method("damage")):
		body.damage(damage);
		