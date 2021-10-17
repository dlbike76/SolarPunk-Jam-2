extends Camera2D

onready var player := get_parent().get_node("Player")

var triggered := false

func _unhandled_input(event: InputEvent) -> void:
	var broken_machines := get_tree().get_nodes_in_group("Broken_Machines")
	if event.is_action_pressed("search"):
		var triggered = true
		for node in broken_machines:
			pan_to_object(node)
			yield(get_tree().create_timer(1.0), "timeout")
		triggered = false
		self.offset = Vector2 (0,0)


func _process(delta: float) -> void:
	if triggered == false:
		
		global_position.y = move_toward(global_position.y, player.position.y, 2.5)
		global_position.x = move_toward(global_position.x, player.position.x, 2.5)


func pan_to_object(node):
	self.offset = Vector2(node.global_position.x-self.global_position.x,node.global_position.y-self.global_position.y)

