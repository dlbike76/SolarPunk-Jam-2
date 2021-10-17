
extends Energy_Machines

onready var animated_sprite := $AnimatedSprite
onready var sfx_fixed := $Fixed
onready var sfx_broke := $Broke

var fixed_signal_sent = false  #  These variables are used so we only
var broke_signal_sent = false  #  send the respective signal once 
var played := false
var played2 := false


func _ready():
	add_to_group("Machines")
	
	

func _process(delta: float) -> void:
#	check_machine_status()
	broken = check_for_broken_status()
	if charge > 90:
		if broken:
			animated_sprite.play("fix")
			if ! self.is_in_group("Fixed_Machines"):
				self.add_to_group("Fixed_Machines")
			if ! sfx_fixed.is_playing() and played == false:
				played = true
				sfx_fixed.play()
			#self.add_to_group("Machines")
			
			#broken = false
		else:
			if ! self.is_in_group("Fixed_Machines"):
				self.add_to_group("Fixed_Machines")
			
			animated_sprite.play("fix") 
			timer += delta
			charge -= delta * 5
	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		if broken:
			charge += 30 * delta
			animated_sprite.play("charging")
	elif (broken):
		animated_sprite.play("idle_broken")
		if ! sfx_fixed.is_playing() and played2 == false:
				played2 = true
				sfx_broke.play()
	else: 
		animated_sprite.play("idle")
		timer += delta
		
#	if timer > 30 and animated_sprite.animation=="idle":   #  The machine will start loosing charge again after 30 seconds
#		charge = 0
#		broken = true
	
func break_machine():
	timer = 0
	charge = 0
	self.remove_from_group("Machines")
	self.add_to_group("Broken_Machines")
	broken = self.is_in_group("Broken_Machines")


func check_for_broken_status() -> bool:
	return self.is_in_group("Broken_Machines")
	
