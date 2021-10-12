extends Node

func check_walls_collision(entity, offset:Vector2) -> bool: 
	var walls := get_tree().get_nodes_in_group("walls")
	for wall in walls:
		if (entity.hitbox.intersects(wall.hitbox, offset)):
			return true
	return false

func check_player_collision(entity, offset:Vector2) -> bool: 
	var players := get_tree().get_nodes_in_group("players")
	for player in players:
		if (entity.hitbox.intersects(player.hitbox, offset)):
			return true
	return false

func check_springs_y_collision(entity, offset:Vector2) -> bool: 
	var springs := get_tree().get_nodes_in_group("springs_y")
	for spring in springs:
		if (entity.hitbox.intersects(spring.hitbox, offset)):
			return true
	return false

func check_springs_x_r_collision(entity, offset:Vector2) -> bool: 
	var springs := get_tree().get_nodes_in_group("springs_x_r")
	for spring in springs:
		if (entity.hitbox.intersects(spring.hitbox, offset)):
			return true
	return false

func check_springs_x_l_collision(entity, offset:Vector2) -> bool: 
	var springs := get_tree().get_nodes_in_group("springs_x_l")
	for spring in springs:
		if (entity.hitbox.intersects(spring.hitbox, offset)):
			return true
	return false

func check_ladders_collision(entity, offset:Vector2) -> bool: 
	var ladders := get_tree().get_nodes_in_group("ladders")
	for ladder in ladders:
		if (entity.hitbox.intersects(ladder.hitbox, offset)):
			return true
	return false

func check_object_interaction_collision(entity, offset:Vector2) -> bool: 
	var objects := get_tree().get_nodes_in_group("interaction_objects")
	for object in objects:
		if (entity.hitbox.intersects(object.hitbox, offset)):
			return true
	return false

func check_water_1_collision(entity, offset:Vector2) -> bool: 
	var waters := get_tree().get_nodes_in_group("water")
	for water in waters:
		if (entity.hitbox.intersects(water.hitbox1, offset)):
			return true
	return false

func check_water_2_collision(entity, offset:Vector2) -> bool: 
	var waters := get_tree().get_nodes_in_group("water")
	for water in waters:
		if (entity.hitbox.intersects(water.hitbox2, offset)):
			return true
	return false


