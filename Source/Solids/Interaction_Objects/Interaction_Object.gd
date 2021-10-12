extends Node2D
class_name Interaction_Object

onready var hitbox := $Hitbox

func _ready() -> void:
	add_to_group("interaction_objects")


