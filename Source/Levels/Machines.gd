extends Node


# This script and associated node will manage the machines breaking and being fixed

#var fixed_signal_sent = false  #  These variables are used so we only
#var broke_signal_sent = false  #  send the respective signal once 
#
#var broken_count = 0
#var fixed_count = 0
#
#signal machine_fixed
#signal machine_broke
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	broken_count = get_tree().get_nodes_in_group("Broken_Machines").size()
#	if broken_count > 0:
#		emit_signal("machine_broke")
#		broke_signal_sent = true
#	fixed_count = get_tree().get_nodes_in_group("Fixed_Machines").size()
#	if fixed_count > 0:
#		emit_signal("machine_fixed")
#		fixed_signal_sent = true
	
