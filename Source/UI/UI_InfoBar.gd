extends ColorRect

#onready var energy_leak_label :Label = get_tree().get_node("UI/InfoBar/Energy_leak/Label")
#onready var energy_total_label :Label = get_tree().get_node("UI/InfoBar/Total_Energy/Label")

var _energy_leaking setget set_energy_leaking, get_energy_leaking
var _energy_total setget set_energy_total, get_energy_total


func set_energy_leaking(amt):
	_energy_leaking = amt
	$Energy_leak.get_node("Label").text = str(int(_energy_leaking))
	#energy_leak_label.text = str(_energy_leaking)

func get_energy_leaking():
	return _energy_leaking

func  set_energy_total(amt):
	_energy_total = amt
	$Total_Energy.get_node("Label").text =str(int(_energy_total))
	#energy_total_label.text = str(_energy_total)

func get_energy_total():
	return _energy_total


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# We need to make sure that the info bar is always shown at the top of the game window
#	var global_pos = get_global_rect()
#	print (global_pos)
#	var new_position = Vector2(0,0)
#
#	set_global_position(new_position)
	pass
