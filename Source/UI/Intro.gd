extends TextureRect

onready var menu : PackedScene = preload("res://Source/UI/TitleMenu.tscn")

func _ready():
	yield(get_tree().create_timer(9.2), "timeout")
	get_tree().change_scene_to(menu)
