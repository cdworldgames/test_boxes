extends Node

const CAIXA = preload("res://scenes/caixa.tscn")  
var spawn_timer = 0.0
@export var spawn_interval: float = 2.0  

func _ready() -> void:
	spawn_timer = spawn_interval
	Global.Left = Color.YELLOW
	Global.Right = Color.GREEN

func _process(delta: float) -> void:
	spawn_timer -= delta
	
	if spawn_timer <= 0:
		spawn_caixa()
		spawn_timer = spawn_interval 

func spawn_caixa() -> void:
	var new_caixa = CAIXA.instantiate()
	new_caixa.path = get_path()
	add_child(new_caixa,true,Node.INTERNAL_MODE_FRONT)  

	new_caixa.position = Vector2(randf_range(100, 1000), 0)
