extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var ladder := $Ladder
onready var sfx_grow := $Grow

var charge = 0.0
var played := false

export var vine_height := 100
export var charge_rate := 30.0

func _process(delta: float) -> void:
	if charge > 90:
		vine_ladder_grow()
		animated_sprite.play("grow")
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += charge_rate * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle")

func vine_ladder_grow():
	ladder.hitbox.height = vine_height
	if ! sfx_grow.is_playing() and played == false:
		sfx_grow.play()
		played = true
	
