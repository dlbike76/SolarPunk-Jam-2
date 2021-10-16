extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var wall := $Wall
onready var the_player : KinematicBody2D =  get_parent().get_parent().get_parent().get_node("Player")

onready var player_energy = the_player.mental_energy

var charge = 0.0

func _process(delta: float) -> void:
	if charge > 90:
		wall_ungrow()
		the_player.mental_energy -= 15
		animated_sprite.play("open")
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		if the_player.mental_energy >= 15:
			charge += 30 * delta
			animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_close")

func wall_grow():
	wall.hitbox.height = 64

func wall_ungrow():
	wall.hitbox.height = 0

