extends ColorRect

var _power setget set_power, get_power
var _mental_energy setget set_mental_energy, get_mental_energy
var _broken_count setget set_broken_count, get_broken_count

export var _max_mental_energy = 100.0
onready var power_sprite : AnimatedSprite = get_node("Power").get_node("AnimatedSprite")
onready var mental_energy_sprite : AnimatedSprite = get_node("Mental_Energy").get_node("AnimatedSprite")

func set_broken_count(count):
	_broken_count = count
	$Broken_Machines.get_node("Label").text = str(int(count))

func get_broken_count():
	return _broken_count


func set_power(amt):
	_power = amt
	$Power.get_node("Label").text = str(int(_power))

func get_power():
	return _power

func  set_mental_energy(amt):
	# We ae capping the mental energy to _max_mental_energy
	if amt < _max_mental_energy :
		_mental_energy = amt
	else:
		_mental_energy = _max_mental_energy 
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
	if _power < 10 :
		power_sprite.set_animation("0")
	elif _power < 20 : 
		power_sprite.set_animation("1")
	elif _power < 30 :
		power_sprite.set_animation("2")
	elif _power < 40 :
		power_sprite.set_animation("3")
	elif _power < 50 :
		power_sprite.set_animation("4")
	elif _power < 60 :
		power_sprite.set_animation("5")
	elif _power < 70 :
		power_sprite.set_animation("6")
	elif _power < 80 :
		power_sprite.set_animation("7")
	else :
		power_sprite.set_animation("8")
	pass
	# same idea as with mental energy

func animate_mental_energy():
	if _mental_energy > 90 :
		mental_energy_sprite.set_animation("12")
	elif _mental_energy > 80 :
		mental_energy_sprite.set_animation("11")
	elif _mental_energy > 70 :
		mental_energy_sprite.set_animation("10")
	elif _mental_energy > 60 :
		mental_energy_sprite.set_animation("9")
	elif _mental_energy > 50 :
		mental_energy_sprite.set_animation("8")
	elif _mental_energy >= 40 :
		mental_energy_sprite.set_animation("7")
	elif _mental_energy > 35 :
		mental_energy_sprite.set_animation("6")
	elif _mental_energy > 30 :
		mental_energy_sprite.set_animation("5")
	elif _mental_energy > 25 :
		mental_energy_sprite.set_animation("4")
	elif _mental_energy > 20 :
		mental_energy_sprite.set_animation("3")
	elif _mental_energy > 15 :
		mental_energy_sprite.set_animation("2")
	elif _mental_energy > 10 :
		mental_energy_sprite.set_animation("1")
	else:
		mental_energy_sprite.set_animation("0")
	
	pass
	# something like:
	# if mental energy < 10 : play "0"
	# elif mental energy < 20 : play "1"
	# ...

