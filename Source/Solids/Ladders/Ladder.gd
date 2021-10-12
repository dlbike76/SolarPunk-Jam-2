extends Node2D

onready var hitbox := $Hitbox

func _ready() -> void:
	add_to_group("ladders")
