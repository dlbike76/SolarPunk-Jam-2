extends Interaction_Object

# Just to test the Mental energy charging

var mental_energy := 0.0
onready var infobar := get_parent().get_node("UI/InfoBar")

func _ready() -> void:
	infobar.set_mental_energy(mental_energy)

func _process(delta: float) -> void:
	if (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		var new_m = infobar.get_mental_energy() + 10*delta
		infobar.set_mental_energy(new_m)
	
