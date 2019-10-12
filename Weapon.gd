#WIP
extends Node2D
signal Action
var fire_rate;
var _fire_iter;

func _init(_fire_rate, _fire_auto):
	fire_rate = _fire_rate;
	_fire_iter = fire_rate;


func check_fire(state):
	if(_fire_iter-1 > 0):
		_fire_iter-=1;


func _fire_action():
	pass
