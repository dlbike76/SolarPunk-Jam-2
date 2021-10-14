extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var wall := $Wall

var charge = 0.0

func _process(delta: float) -> void:
	if charge > 90:
		wall_ungrow()
		animated_sprite.play("open")
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_close")

func wall_grow():
	wall.hitbox.height = 64

func wall_ungrow():
	wall.hitbox.height = 2

