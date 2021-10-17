extends AnimatedSprite

func _ready() -> void:
	self.play("idle")

func _on_InteractionBox_activated() -> void:
	self.play("activate")
