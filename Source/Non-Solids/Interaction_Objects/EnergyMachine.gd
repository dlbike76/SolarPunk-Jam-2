extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var sfx_fixed := $Fixed
onready var sfx_broke := $Broke

var _fixed_signal_sent = false  #  These variables are used so we only
var _broke_signal_sent = false  #  send the respective signal once 

signal machine_fixed
signal machine_broke

var played := false
var played2 := false
var charge = 0.0 
var timer = 0    # A Timer that starts counting once the machine if fixed

func _process(delta: float) -> void:
	if charge > 90:
		animated_sprite.play("fix")
		if ! sfx_fixed.is_playing() and played == false:
			played = true
			sfx_fixed.play()
		if !_fixed_signal_sent:
			emit_signal("machine_fixed")
			_fixed_signal_sent = true
		timer += delta
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 25 * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_broken")
		if !_broke_signal_sent:
			emit_signal("machine_broke")
			
			if ! sfx_fixed.is_playing() and played2 == false:
				played2 = true
				sfx_broke.play()
			
			_broke_signal_sent = true
		timer = 0
		if _fixed_signal_sent:
			_fixed_signal_sent = false
			_broke_signal_sent = false
	if timer > 30:   #  The machine will start loosing charge again after 30 seconds
		charge = 0

