extends Interaction_Object

onready var tween := get_parent().get_node("Tween")
#onready var animated_sprite := $AnimatedSprite

var charge := 0.0

signal activated


#func _ready() -> void:
	#animated_sprite.play("idle")


func _process(delta: float) -> void:
	if charge > 90:
		emit_signal("activated")
		#animated_sprite.play("activate")
		#self.set_as_toplevel(true)
		tween.start()
	if (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
