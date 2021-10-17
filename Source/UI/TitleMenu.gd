extends ColorRect

onready var title_menu = $Menu
onready var game : PackedScene = preload("res://Source/Levels/Level.tscn")
onready var intro_sound : AudioStreamMP3 = preload("res://Assets/Sounds/Song-3.mp3")
onready var sound_player : AudioStreamPlayer = get_parent().get_node("AudioStreamPlayer")


signal options_menu_request(caller)
signal quit_game_request
signal new_game_request

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	sound_player.stream = intro_sound
	sound_player.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameInfo_pressed():
	get_parent().get_node("GameInfo").show()






func _on_Options_pressed():
	emit_signal("options_menu_request","Title")


func _on_QuitGame_pressed():
	get_tree().quit()


func _on_NewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(game)
