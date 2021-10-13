extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var the_camera : Camera2D = get_parent().get_parent().get_node("Camera")
#
#var camera_offset : Vector2

signal options_menu_request(caller)
signal quit_game_request

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.



#func _process(delta):
#	pass



func _unhandled_input(event):
	#This isn't working to hide the menu - need to investigate why...
	if event.is_action_pressed("ui_cancel"):
		self.hide()

func _on_QuitGame_pressed():
	emit_signal("quit_game_request")


func _on_Continue_pressed():
	get_tree().paused = false
	self.hide()


func _on_Options_pressed():
	self.hide()
	emit_signal("options_menu_request","Game")

