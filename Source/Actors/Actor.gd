extends Node2D
class_name Actor

var remainder := Vector2.ZERO
var velocity := Vector2.ZERO

func _ready() -> void:
	add_to_group("actors")

func move_x(amount, callback) -> void:
	remainder.x += amount
	var move_x := round(remainder.x)
	if move_x != 0:
		remainder.x -= move_x
		move_x_exact(move_x, callback)

func move_y(amount, callback) -> void:
	remainder.y += amount
	var move_y := round(remainder.y)
	if move_y != 0:
		remainder.y -= move_y
		move_y_exact(move_y, callback)

func move_x_exact(amount, callback) -> void:
	var step := sign(amount)
	while amount != 0:
		if Game.check_walls_collision(self, Vector2(step,0)):
			callback.call_func()
			return
		global_position.x += step
		amount -= step
	
func move_y_exact(amount, callback) -> void:
	var step := sign(amount)
	while amount != 0:
		if Game.check_walls_collision(self, Vector2(0,step)):
			callback.call_func()
			return
		global_position.y += step
		amount -= step

func zero_remainder_x():
	remainder.x = 0
	
func zero_remainder_y():
	remainder.y = 0



