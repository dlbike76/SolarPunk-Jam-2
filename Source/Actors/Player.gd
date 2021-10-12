extends Actor

onready var animated_sprite := $AnimatedSprite
onready var hitbox := $Hitbox

export var max_speed := 100
export var acceleration := 120
export var acceleration_up_trigger := 30
export var acceleration_up_coeficient := 4
export var friction := 250
export var gravity := 1000
export var max_fall_speed := 5000

signal interaction

func _ready() -> void:
	add_to_group("players")

func _process(delta: float) -> void:
	check_collisions_with_non_walls()
	var direction_x := (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	var direction_y := (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	velocity = calculate_velocity(direction_x, direction_y)
	move_x(velocity.x * delta, funcref(self, "wall_collision_x"))
	move_y(velocity.y * delta, funcref(self, "wall_collision_y"))
	animate()

func check_collisions_with_non_walls ():
	if Game.check_springs_y_collision(self,Vector2(0,1)) : coll_spring_y()
	if Game.check_springs_x_r_collision(self,Vector2(-1,0)) : coll_spring_x_r()
	if Game.check_springs_x_l_collision(self,Vector2(1,0)) : coll_spring_x_l()

func calculate_velocity(direction_x: float, direction_y: float) -> Vector2:
	var out := velocity
	if (Game.check_object_interaction_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		out.x == 0
		out.x = move_toward(out.x, 0, friction * get_process_delta_time())
	else:
		if Game.check_ladders_collision(self,Vector2(0,0)) :
			out.y += acceleration * direction_y * get_process_delta_time()
			if direction_y == 0 : out.y = move_toward(out.y, 0, friction * get_process_delta_time())
		else:
			out.y += gravity * get_process_delta_time()
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
					if velocity.x > 0 : animated_sprite.play("walk_right")
					elif velocity.x <0 : animated_sprite.play("walk_left")
					else : animated_sprite.play("idle")

func wall_collision_x():
	zero_remainder_x()
	velocity.x = 0

func wall_collision_y():
	zero_remainder_y()
	velocity.y = 0

func coll_spring_y():
	velocity.y = -500

func coll_spring_x_r():
	velocity.x = 500

func coll_spring_x_l():
	velocity.x = -500





