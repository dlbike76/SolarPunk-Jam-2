extends Interaction_Object

onready var infobar := get_parent().get_node("UI/InfoBar")
onready var animated_sprite := $AnimatedSprite

var mental_energy := 0.0


func _ready() -> void:
	infobar.set_mental_energy(mental_energy)

func _process(delta: float) -> void:
	if (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		animated_sprite.play("charge")
		
		var new_m = infobar.get_mental_energy() + 10*delta
		infobar.set_mental_energy(new_m)
		
	else: animated_sprite.play("idle")
	
