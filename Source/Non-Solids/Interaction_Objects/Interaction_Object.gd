extends Node2D
class_name Interaction_Object

onready var hitbox := $Hitbox


var charge = 0.0 
var timer = 0    # A Timer that starts counting once the machine if fixed

func _init(the_charge := 0.0, the_timer := 0):
	charge = the_charge
	timer = the_timer


func _ready() -> void:
	add_to_group("interaction_objects")


