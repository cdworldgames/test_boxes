extends CharacterBody2D

@export var speed: float = 200.0

func GetInput() -> void:
	var move_direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = move_direction * speed
	move_and_slide()

func _physics_process(_delta: float) -> void:
	if Global.PointsG < ((Global.LevelG * 20) * 9):
		GetInput()
