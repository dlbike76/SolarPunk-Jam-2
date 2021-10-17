extends ColorRect


onready var power_sprite : AnimatedSprite = get_node("Power").get_node("AnimatedSprite")
onready var mental_energy_sprite : AnimatedSprite = get_node("Mental_Energy").get_node("AnimatedSprite")
onready var broken_count_sprite : AnimatedSprite = get_node("Broken_Machines").get_node("AnimatedSprite")
onready var clock_sprite : AnimatedSprite = get_node("Global_Countdown").get_node("Clock")
onready var clock_back_sprite : AnimatedSprite = get_node("Broken_Machines").get_node("Background")


export var _min = 0.0
export var _max = 100.0

var _power setget set_power, get_power
var _mental_energy setget set_mental_energy, get_mental_energy
var _broken_count setget set_broken_count, get_broken_count
var global_counter 
var global_countdown_amount 

var default_amount = 5.0 * 60

func _ready():
	clock_sprite.play("tick")
	global_countdown_amount = default_amount
	global_counter = 0.0

func add_status_msg(msg):
	$StatusMsg.get_node("Label").text = str($StatusMsg.get_node("Label").text," ", msg)

func show_status_msg(msg):
	$StatusMsg.get_node("Label").text = msg
	$StatusMsg.show()

func hide_status_msg():
	$StatusMsg.hide()

func set_global_countdown_amount(amt):
	global_countdown_amount = amt
	

func get_global_countdown() -> float:
	var amt = global_countdown_amount - global_counter
	return amt   # returned in minutes


func set_broken_count(count):
	_broken_count = count
	$Broken_Machines.get_node("Label").text = str(int(count))

func get_broken_count():
	return _broken_count

func set_power(amt):
	if amt < _max :
		_power = amt
	else:
		_power = _max
	if amt < _min :
		_power = _min
	$Power.get_node("Label").text = str(int(_power))

func get_power():
	return _power

func  set_mental_energy(amt):
	if amt < _max :
		_mental_energy = amt
	else:
		_mental_energy = _max
	if amt < _min :
		_mental_energy = _min
	$Mental_Energy.get_node("Label").text = str(int(_mental_energy))

func get_mental_energy():
	return _mental_energy

func _process(delta: float) -> void:
	global_counter += delta
	var countdown_minutes = int(get_global_countdown() / 60)
	var countdown_seconds = int(get_global_countdown() ) % 60
		
	$Global_Countdown.get_node("Counter").text = str( countdown_minutes, ":", str(countdown_seconds).pad_zeros(2))
	animate_power()
	animate_mental_energy()
	animate_broken_counts()
	

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

func animate_broken_counts():
	if _broken_count == 0:
		broken_count_sprite.set_animation("0")
	if _broken_count == 1:
		broken_count_sprite.set_animation("1")
	if _broken_count == 2:
		broken_count_sprite.set_animation("2")
	if _broken_count == 3:
		broken_count_sprite.set_animation("3")
	if _broken_count == 4:
		broken_count_sprite.set_animation("4")
	if _broken_count == 5:
		broken_count_sprite.set_animation("5")
	if _broken_count == 6:
		broken_count_sprite.set_animation("6")

func animate_clock_counts():
	if _broken_count == 0:
		broken_count_sprite.set_animation("0")
	if _broken_count == 1:
		broken_count_sprite.set_animation("1")
	if _broken_count == 2:
		broken_count_sprite.set_animation("2")
	if _broken_count == 3:
		broken_count_sprite.set_animation("3")
	if _broken_count == 4:
		broken_count_sprite.set_animation("4")
	if _broken_count == 5:
		broken_count_sprite.set_animation("5")
