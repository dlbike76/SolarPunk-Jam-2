extends Wall
class_name Solid

var remainder := Vector2.ZERO

func move_x (amount):
	remainder.x += amount
	var move = round(remainder.x)
	if move != 0:
		var riders = Game.get_all_riding_actors(self)
		remainder.x -= move
		global_position.x += move
		for actor in Game.get_all_actors():
			if hitbox.intersects(actor.hitbox, Vector2.ZERO):
				if move > 0:
					actor.move_x_exact(hitbox.rx_w - actor.hitbox.rx, funcref(actor,"squish"))
				else:
					actor.move_x_exact(hitbox.rx - actor.hitbox.rx_w, funcref(actor,"squish"))
			elif riders.has(actor):
				actor.move_x_exact(move,null)


func move_y (amount):
	remainder.y += amount
	var move = round(remainder.y)
	if move != 0:
		var riders = Game.get_all_riding_actors(self)
		remainder.y -= move
		global_position.y += move
		for actor in Game.get_all_actors():
			if hitbox.intersects(actor.hitbox, Vector2.ZERO):
				if move > 0:
					actor.move_y_exact(hitbox.ry_h - actor.hitbox.ry, funcref(actor,"squish"))
				else:
					actor.move_y_exact(hitbox.ry - actor.hitbox.ry_h, funcref(actor,"squish"))
			elif riders.has(actor):
				actor.move_y_exact(move,null)
