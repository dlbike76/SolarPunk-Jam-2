extends Camera2D

onready var player := get_parent().get_node("Player")

var triggered := false

func _process(delta: float) -> void:
	if player.position.y < global_position.y :
		triggered = true
	if triggered:
		global_position.y = move_toward(global_position.y, player.position.y, 2.5)
	
