extends Node2D
class_name Wall

onready var hitbox := $Hitbox

func _ready() -> void:
	add_to_group("walls")
