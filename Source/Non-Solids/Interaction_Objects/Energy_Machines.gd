class_name Energy_Machines
extends Interaction_Object

var broken = false

var charge = 0.0 
var timer = 0    # A Timer that starts counting once the machine if fixed

func _init(the_charge := 0.0, the_timer := 0, is_broken := false):
	broken = is_broken
	charge = the_charge
	timer = the_timer





			
