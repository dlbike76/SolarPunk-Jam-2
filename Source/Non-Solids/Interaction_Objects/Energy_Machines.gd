class_name Energy_Machines
extends Interaction_Object

var broken = false
var power_lost = 0.0
var power_timer = 0.0

func _init(is_broken := false, the_power_lost := 0.0, the_power_timer := 0.0):
	broken = is_broken
	power_lost = the_power_lost
	power_timer = the_power_timer
