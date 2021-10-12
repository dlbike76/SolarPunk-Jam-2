extends Node2D

onready var hitbox := $Hitbox
onready var animated_sprite := $AnimatedSprite
onready var player := get_parent().get_parent().get_node("Player")

func _ready() -> void:
	add_to_group("springs_y")

func _process(delta: float) -> void:
	if player.hitbox.intersects(self.hitbox, Vector2(0,1)):
		animated_sprite.play("activate")
		yield(get_tree().create_timer(0.5), "timeout")
		animated_sprite.play("idle")

