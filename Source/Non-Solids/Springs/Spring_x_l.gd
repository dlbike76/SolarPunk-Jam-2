extends Node2D

onready var hitbox := $Hitbox
onready var animated_sprite := $AnimatedSprite
onready var player := get_parent().get_parent().get_parent().get_node("Player")

func _ready() -> void:
	add_to_group("springs_x_l")

func _process(delta: float) -> void:
	if player.hitbox.intersects(self.hitbox, Vector2(1,0)):
		animated_sprite.play("activate")
		yield(get_tree().create_timer(0.5), "timeout")
		animated_sprite.play("idle")

