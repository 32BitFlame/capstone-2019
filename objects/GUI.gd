extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/Gauge
onready var tween = $Tween
onready var plr = get_parent().get_node("Player");


# Called when the node enters the scene tree for the first time.
func _ready():
	var player_max_health = $"../Player".max_health
	bar.max_value = player_max_health
	update_health(player_max_health)

func _physics_process(delta):
	rect_position = Vector2(plr.position.x - (get_viewport().size.x / 2), plr.position.y - (get_viewport().size.y / 2))

func _on_Player_damage(player_health):
	update_health(player_health)
	
func update_health(new_value):
    number_label.text = str(new_value)
    bar.value = new_value
