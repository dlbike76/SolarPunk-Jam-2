extends Camera2D

onready var player := get_parent().get_node("Player")

var triggered := false

func _process(delta: float) -> void:
	var broken_machines := get_tree().get_nodes_in_group("broken_machines")
	if Input.is_action_pressed("search"): 
		for node in broken_machines:
			pan_to_object(node)
			yield(get_tree().create_timer(2.0), "timeout")
	else:
		global_position.y = move_toward(global_position.y, player.position.y, 2.5)
		global_position.x = move_toward(global_position.x, player.position.x, 2.5)


func pan_to_object(node):
	global_position.y = move_toward(global_position.y, node.position.y, 5)
	global_position.x = move_toward(global_position.x, node.position.x, 5)
