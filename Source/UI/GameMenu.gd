extends CanvasLayer


onready var the_menu = get_node("Menu")

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
		the_menu.hide()

func _on_QuitGame_pressed():
	emit_signal("quit_game_request")


func _on_Continue_pressed():
	the_menu.hide()


func _on_Options_pressed():
	the_menu.hide()
	emit_signal("options_menu_request","Game")



#func _on_GameMenu_visibility_changed():
#	if self.visible :
#		the_menu.show()
#		get_tree().paused = true
#	else :
#		the_menu.hide()
#		get_tree().paused = false


func _on_Menu_visibility_changed():
	if the_menu.visible:
		the_menu.show()
		get_tree().paused = true
	else :
		the_menu.hide()
		get_tree().paused = false
