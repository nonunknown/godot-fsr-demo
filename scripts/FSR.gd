extends Node3D

@onready var car := $Car
@onready var spawn_pos:Vector3 = $SpawnPos.global_transform.origin

func _ready() -> void:
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_accept"):
		var new_car = car.duplicate()
		add_child(new_car)
		new_car.global_transform.origin = spawn_pos
	elif event.is_action_pressed("ui_cancel"):
		var cars := get_tree().get_nodes_in_group(&"CAR")
		if cars.size()-1 > 0:
			cars[cars.size()-1].queue_free()
		pass
