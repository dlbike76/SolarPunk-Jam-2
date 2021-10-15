extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var ladder := $Ladder

onready var the_player : KinematicBody2D =  get_parent().get_parent().get_parent().get_node("Player")

onready var player_energy = the_player.mental_energy

var used = false
var charge = 0
var timer = 0

func _process(delta: float) -> void:
	if (charge > 90 ):
		vine_ladder_grow()
		animated_sprite.play("grow")
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle")
	
	if used == true:
		timer += delta
	
	if timer >= 120:
		used = false
		charge = 0.0

func vine_ladder_grow():
	ladder.hitbox.height = 100 
