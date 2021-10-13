extends Interaction_Object

onready var animated_sprite := $AnimatedSprite

var charge = 0.0

func _process(delta: float) -> void:
	if charge > 90:
		animated_sprite.play("fix")
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_broken")
