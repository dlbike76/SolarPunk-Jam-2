extends ColorRect

onready var title_menu = $Menu

signal options_menu_request(caller)
signal quit_game_request
signal new_game_request

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameInfo_pressed():
	pass # Replace with function body.





func _on_Options_pressed():
	emit_signal("options_menu_request","Title")


func _on_QuitGame_pressed():
	emit_signal("quit_game_request")


func _on_NewGame_pressed():
	emit_signal("new_game_request")
