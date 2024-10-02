extends CharacterBody2D

var rand = RandomNumberGenerator.new()
var id
@onready var cor: ColorRect = $Color
@export var gravity: float = 300.0

var path: NodePath
@onready var LeftBox: Node2D
@onready var RightBox: Node2D


func _ready():
	LeftBox = get_node(str(path) + "/LeftBox")
	RightBox = get_node(str(path) + "/RightBox")
	id = rand.randi_range(0, 3)
	match id:
		0:
			cor.color = Color.RED # Vermelho
		1:
			cor.color = Color.GREEN # Verde
		2:
			cor.color = Color.BLUE # Azul
		3:
			cor.color = Color.YELLOW # Amarelo

func _physics_process(delta: float) -> void:
	
	if Global.PointsG < (Global.LevelG * 20) * 9:
		velocity.y += gravity * delta 
		move_and_slide()

func _on_body_entered(body: Node) -> void:
	print("Colidiu com o corpo: ", body.name)
	if body.is_in_group("Floor"):
		if cor.color == Global.Left or cor.color == Global.Right:
			Global.PointsG -= 10
			Global.Box = max(0, Global.Box - 1)
			
			if Global.LeftBox > Global.RightBox:
				Global.LeftBox = max(0, Global.LeftBox -1) # Evita valores negativos
				LeftBox.remove_box()
			else :
				Global.RightBox = max(0, Global.RightBox -1) # Evita valores negativos
				RightBox.remove_box()
		
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	print("Colidiu com a área: ", area.name, "Pai: ", area.get_parent().name)
	if area.is_in_group("Car"):
		if cor.color == Global.Left or cor.color == Global.Right:
			Global.PointsG += 10
			Global.Box += 1
			
			
			if Global.LeftBox <= Global.RightBox:
				LeftBox.add_box(self)
				Global.LeftBox += 1
			else:
				RightBox.add_box(self)
				Global.RightBox += 1
			return
		else:
			Global.PointsG -= 10
			Global.Box = max(0, Global.Box - 1)
			print("Erro: cor incorreta")
			
			if Global.LeftBox > Global.RightBox:
				Global.LeftBox = max(0, Global.LeftBox - 1)  # Evita valores negativos
				LeftBox.remove_box()
			else:
				Global.RightBox = max(0, Global.RightBox - 1)  # Evita valores negativos
				RightBox.remove_box()
		
		queue_free()
