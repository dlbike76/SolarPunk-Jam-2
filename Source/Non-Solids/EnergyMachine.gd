extends Interaction_Object

onready var animated_sprite := $AnimatedSprite

var _fixed_signal_sent = false  #  These variables are used so we only
var _broke_signal_sent = false  #  send the respective signal once 

signal machine_fixed
signal machine_broke

var charge = 0.0
var timer = 0    # A Timer that starts counting once the machine if fixed

func _process(delta: float) -> void:
	if charge > 90:
		animated_sprite.play("fix")
		if !_fixed_signal_sent:
			emit_signal("machine_fixed")
			_fixed_signal_sent = true
		timer += delta
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		charge += 30 * delta
		animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_broken")
		if !_broke_signal_sent:
			emit_signal("machine_broke")
			_broke_signal_sent = true
		timer = 0
		if _fixed_signal_sent:
			_fixed_signal_sent = false
			_broke_signal_sent = false
	if timer > 5:   #  The machine will start loosing charge again after 30 seconds
		charge -= delta
		
