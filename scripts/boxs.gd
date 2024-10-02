extends Node2D

enum NamesBoxes {LeftBox=0 , RightBox=1}

@export var name_box: NamesBoxes
@onready var pos_boxes: Array = $PosBoxes.get_children()

var coll_boxes: Array[CharacterBody2D] 

func add_box(box:CharacterBody2D) -> void:
	box.set_physics_process(false)
	
	if coll_boxes.size() < pos_boxes.size():
		box.global_position = pos_boxes[coll_boxes.size()].global_position
		coll_boxes.append(box)

func remove_box() -> void:
	if coll_boxes.size() > 0:
		var box = coll_boxes.pop_back()
		box.queue_free()
