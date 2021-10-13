extends ColorRect

var _power setget set_power, get_power
var _mental_energy setget set_mental_energy, get_mental_energy


func set_power(amt):
	_power = amt
	$Power.get_node("Label").text = str(int(_power))

func get_power():
	return _power

func  set_mental_energy(amt):
	_mental_energy = amt
	$Mental_Energy.get_node("Label").text = str(int(_mental_energy))

func get_mental_energy():
	return _mental_energy

func _process(delta: float) -> void:
	animate_power()
	animate_mental_energy()

# here with the animate functions, the idea is that depending how high or low is the number (between 0 and 100),
# of the labels, the icons will be playing diferent animations (they are not really animations, they are static)
# but label text is a string. I am sure you can convert easily a number in a string to an int number, but i dont know how.
# if you can tackle it, great! if dont, ill look later into it

func animate_power():
	pass
	# same idea as with mental energy

func animate_mental_energy():
	pass
	# something like:
	# if mental energy < 10 : play "0"
	# elif mental energy < 20 : play "1"
	# ...

