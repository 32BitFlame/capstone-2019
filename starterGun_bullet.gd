extends KinematicBody2D
const speed = 200;
var velocityVector;
var started = false;

func StartMovement(x,y,tx, ty):
	started = true
	self.position = Vector2(x,y);
	velocityVector = Vector2(x - tx, y - ty);
	velocityVector = velocityVector.normalized() * speed;

func _physics_process(delta):
	if(!started):
		return
	move_and_slide(velocityVector)