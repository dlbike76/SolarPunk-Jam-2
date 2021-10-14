extends Node2D

onready var animated_sprite := $AnimatedSprite
onready var infobar := get_parent().get_parent().get_node("UI/InfoBar")
onready var hitbox := $Hitbox

var mental_energy := 0.0
var alive = true

func _ready() -> void:
	infobar.set_mental_energy(mental_energy)

func _process(delta: float) -> void:
	if alive == true : animated_sprite.play("idle")
	if Game.check_player_collision(self,Vector2(0,0)) and alive == true:
		alive = false
		var new_m = infobar.get_mental_energy() + 10
		infobar.set_mental_energy(new_m)
		animated_sprite.play("death")
		
		# if queue free, the game lags, so for the moment, i just leave it there, not interacting. 
		
		#yield(get_tree().create_timer(5.0), "timeout")
		#queue_free()

