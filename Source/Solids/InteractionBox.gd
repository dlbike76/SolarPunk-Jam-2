extends Interaction_Object

onready var tween := get_parent().get_node("Tween")

var charge := 0.0


func _process(delta: float) -> void:
	if charge > 90:
		tween.start()
	if (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
