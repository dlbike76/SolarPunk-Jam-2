extends Interaction_Object

onready var infobar := get_parent().get_parent().get_parent().get_node("UI/InfoBar")
onready var animated_sprite := $AnimatedSprite

var mental_energy := 0.0
var max_energy := 30.0   # Max energy per 120 seconds
var charger_empty = false
#var timer = 0


func _ready() -> void:
	infobar.set_mental_energy(mental_energy)

#the charger seems to only display the idle animation, i left comented where the other animations should be, but i havent trully read the code
func _process(delta: float) -> void:
	if (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action") and !charger_empty): 
		animated_sprite.play("charge")
		
		var energy_recieved = 10 * delta
		if energy_recieved > max_energy:
			energy_recieved = max_energy
			charger_empty = true
			self.hide()
			#animated_sprite-play("empty") 
		max_energy -= energy_recieved
		var new_m = infobar.get_mental_energy() + energy_recieved
		infobar.set_mental_energy(new_m)
		
	else: animated_sprite.play("idle")
	
	if charger_empty:
		timer += delta
	
	if timer >= 120:
		timer = 0
		max_energy = 30.0
		charger_empty = false
		self.show()
		#animated_sprite-play("idle") 
