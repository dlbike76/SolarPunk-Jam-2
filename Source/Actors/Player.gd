extends Actor

onready var animated_sprite := $AnimatedSprite
onready var hitbox := $Hitbox
onready var infobar := get_parent().get_node("UI/InfoBar")
onready var sfx_jump :=  $Jump
onready var sfx_interact :=  $Interact
#onready var sfx_walk := $Walk

export var max_speed := 100
export var acceleration := 120
export var acceleration_up_trigger := 30
export var acceleration_up_coeficient := 4
export var friction := 250
export var gravity := 850
export var max_fall_speed := 5000
export var power := 100.0  
export var mental_energy := 0.0
export var broken_machines := 0

var power_lost = 0.0
var on_ladder := false

onready var intro_sound : AudioStreamMP3 = preload("res://Assets/Sounds/Intro.mp3")
onready var song1 : AudioStreamMP3 = preload("res://Assets/Sounds/Song-1.mp3")
onready var sound_player : AudioStreamPlayer = get_parent().get_node("Music")

export var initial_break_time = 5.0
export var secondary_break_time = 15.0
var break_time = initial_break_time

func _ready() -> void:
	add_to_group("players")
	infobar.set_power(power)
	infobar.set_mental_energy(mental_energy)
	infobar.set_broken_count(broken_machines)
	sound_player.stream = song1
	sound_player.play()
	randomize()


# Here we implement the in-game menu
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		get_parent().get_node("UI/GameMenu").show()

# As is to be expected, most everything having to do with the game
# is happening in the _process function

func _process(delta: float) -> void:
	check_collisions_with_non_walls()
	var direction_x := (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	var direction_y := (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	velocity = calculate_velocity(direction_x, direction_y)
	move_x(velocity.x * delta, funcref(self, "wall_collision_x"))
	move_y(velocity.y * delta, funcref(self, "wall_collision_y"))
	animate()
	power = infobar.get_power()
	mental_energy = infobar.get_mental_energy()
	
	if broken_machines < 6:
		break_one_machine(break_time)  # break one machine every 15 seconds (controlled by secondary_break_time)
	check_for_broken_machines()  # Here we iterate through the group of broken machines
	check_for_fixed_machines()   # Here we iterate through the group of fixed machines
	
	# Here we get an updated broken count in case a machine has broke in the time 
	# between the check for broken machines and the check for fixed machines 
	var broken_count = get_tree().get_nodes_in_group("Broken_Machines").size()
	
	if (power > 0) and (broken_count > 0) :     
		var power_used = (power/60) * delta      # essentially 1 power loss per second
		power_lost += power_used                 
		var new_total = infobar.get_power() - power_used
		infobar.set_power(new_total)             # Adjust the UI to relect the power loss
	
	# Here we check if the power has hit or below 0 which triggers a game loss 
	if infobar.get_power() <= 0 :
		get_tree().paused = true
		get_parent().get_node("UI/GameOverMenu").show()

func check_collisions_with_non_walls ():
	if Game.check_springs_y_collision(self,Vector2(0,1)) : coll_spring_y()
	if Game.check_object_interaction_collision(self,Vector2(0,0)) and Input.is_action_pressed("action"): 
		if !sfx_interact.is_playing():
			sfx_interact.play()
	else: sfx_interact.stop()
	
func calculate_velocity(direction_x: float, direction_y: float) -> Vector2:
	var out := velocity
	if (Game.check_object_interaction_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		out.x = 0
		out.x = move_toward(out.x, 0, friction * get_process_delta_time())
	else:
		if Game.check_ladders_collision(self,Vector2(0,0)) and direction_y != 0:
			on_ladder = true
			out.y += acceleration * direction_y * get_process_delta_time()
			out.y = clamp(out.y, -65, 65)
		if ! Game.check_ladders_collision(self,Vector2(0,0)): on_ladder = false
		if on_ladder == true and direction_y == 0: out.y = 0
		if on_ladder == false: out.y += gravity * get_process_delta_time()
		if (direction_x > 0 and velocity.x >= 0) or (direction_x < 0 and velocity.x <= 0):
			if abs(velocity.x) < acceleration_up_trigger:
				out.x += acceleration * direction_x * get_process_delta_time() * acceleration_up_coeficient
			elif abs(velocity.x) >= acceleration_up_trigger:
				out.x += acceleration * direction_x * get_process_delta_time() 
		if (direction_x < 0 and velocity.x > 0) or (direction_x > 0 and velocity.x < 0):
			out.x += acceleration * direction_x * get_process_delta_time() * acceleration_up_coeficient
		if direction_x == 0:
			out.x = move_toward(out.x, 0, friction * get_process_delta_time())
		out.x = clamp(out.x, -max_speed,  max_speed)
		out.y = clamp(out.y, -max_fall_speed, max_fall_speed)
	return out


func animate() -> void:
	if Game.check_object_interaction_collision(self,Vector2(0,0)) and Input.is_action_pressed("action"):
		animated_sprite.play("power")
	else:
		if Game.check_ladders_collision(self,Vector2(0,0)) and not Game.check_walls_collision(self,Vector2(0,1)) :
			 if velocity.y == 0 : animated_sprite.play("climb_idle")
			 elif abs(velocity.y) > 0 : animated_sprite.play("climb")
		else:
			if not Game.check_walls_collision(self,Vector2(0,1)):
				if velocity.y > 10 : animated_sprite.play("fall")
				elif velocity.y < -10 : animated_sprite.play("jump")
			else:
				if Game.check_walls_collision(self,Vector2(1,0)): animated_sprite.play("collision_right")
				elif Game.check_walls_collision(self,Vector2(-1,0)): animated_sprite.play("collision_left")
				else:
					if velocity.x > 0 : 
						animated_sprite.play("walk_right")
					elif velocity.x <0 : 
						animated_sprite.play("walk_left")
					else : animated_sprite.play("idle")

func wall_collision_x():
	zero_remainder_x()
	velocity.x = 0

func wall_collision_y():
	zero_remainder_y()
	velocity.y = 0

func coll_spring_y():
	velocity.y = -400
	sfx_jump.play()


func is_riding(solid, offset):
	return !hitbox.intersects(solid.hitbox, Vector2.ZERO) && hitbox.intersects(solid.hitbox, offset)

func squish():
	print ("squished")




func _on_GameMenu_options_menu_request(caller):
	# add the options menu scene to the scene tree and show it
	pass


func _on_GameMenu_quit_game_request():
	#Call a quit game function in case additional clean-up is needed
	quit_game()
	

func new_game():
	infobar.set_power( power )
	infobar.set_mental_energy( mental_energy)
	get_tree().paused = false


func quit_game() -> void :
	get_tree().quit()


func _on_NoButton_pressed():
	quit_game()


func _on_YesButton_pressed():
	get_parent().get_node("UI/GameOverMenu").hide()
	get_tree().reload_current_scene()
	get_tree().paused = false
	

func break_one_machine(amount_of_time):
	#breakpoint
	var machines = get_tree().get_nodes_in_group("Machines")
	machines.shuffle()
	var the_machine = machines.pop_back()
	if the_machine != null:
		var machine_timer = the_machine.get_timer()
		if machine_timer > amount_of_time:
			the_machine.break_machine()
			break_time = secondary_break_time  # We start at 15, but change it to 45 after the first
			for Node in machines:
				the_machine = machines.pop_back()
				if the_machine != null:
					the_machine.timer = 0
	



# Here we get the count of the # of broken machines based on how
# many nodes are in the "Broken_Machines" group.
# We should probably do something here to determine how much power is lost

func check_for_broken_machines():    
	var machines = get_tree().get_nodes_in_group("Broken_Machines")
	var broken_count =  machines.size()     # This is the number of nodes in the "Broken" group
	infobar.set_broken_count(broken_count)  # We update the UI to show the current broken count
	
	if broken_count > 0:
		broken_machines = broken_count  
	
	# This code is strictly for debug purposes at the moment
	# We iterate over the group of broken machines and output them to the statusMsg in the UI
	# We should probably do something here to determine the power loss more accurately
	
	for Node in machines:   
		var the_machine = machines.pop_front()
		if the_machine != null:
			infobar.show_status_msg(str(broken_count, " ", get_tree().get_nodes_in_group("Broken_Machines"),
				get_tree().get_nodes_in_group("Fixed_Machines")))  


func check_for_fixed_machines():
	var machines = get_tree().get_nodes_in_group("Fixed_Machines")
	var fixed_count = machines.size()
	#broken_machines -= fixed_count
	#infobar.show_status_msg(str("Broken Count: ", broken_machines, "Fixed Count: ",fixed_count) )
	if fixed_count > 0:              
		var power_addition = power_lost * (fixed_count * 0.5)
		var current_power = infobar.get_power()
		infobar.set_power( current_power + power_addition)
	else:
		#do nothing
		pass

	if fixed_count > 0 :
		for Node in machines:
			var the_machine = machines.pop_front()
			if the_machine != null:
				the_machine.charge = 0
				the_machine.timer = 0
				var in_broken = the_machine.is_in_group("Broken_Machines")
				if in_broken:
					the_machine.remove_from_group("Broken_Machines")
					the_machine.remove_from_group("Fixed_Machines")
					the_machine.add_to_group("Machines")
			
			
			#print("In check_for_fixed_machines")
			infobar.show_status_msg(str(get_tree().get_nodes_in_group("Broken_Machines"),
				get_tree().get_nodes_in_group("Fixed_Machines")))              


# These are not used any longer and can be removed
#func _on_EnergyMachine_machine_fixed():
#	# The machine is fixed, so we should stop leaking energy.
#	var power_addition = power_lost * (broken_machines * 0.5)
#	broken_machines -= 1
#	power_lost = 0
#	var current_power = infobar.get_power()
#	print('Broken count after fixed:',broken_machines)
#	infobar.set_power( current_power + power_addition)
#	infobar.set_broken_count(broken_machines)
#
#
#func _on_EnergyMachine_machine_broke():
#	print("broken: ", broken_machines)
#	broken_machines += 1;
#	infobar.set_broken_count(broken_machines)
#	pass # Replace with function body.
