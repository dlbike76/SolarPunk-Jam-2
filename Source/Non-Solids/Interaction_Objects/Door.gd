extends Interaction_Object

onready var animated_sprite := $AnimatedSprite
onready var wall := $Wall
onready var the_player : KinematicBody2D =  get_parent().get_parent().get_parent().get_node("Player")

onready var player_energy = the_player.mental_energy

var opened

func _init(is_opened = false):
	self.opened = is_opened

func _process(delta: float) -> void:
	if self.charge > 90:
		if ! self.opened :
			wall_ungrow()
			the_player.try_use_energy(15)
			animated_sprite.play("open")

	elif (Game.check_player_collision(self,Vector2(0,0)) and Input.is_action_pressed("action")): 
		if the_player.mental_energy >= 15:
			self.charge += 30 * delta
			animated_sprite.play("charging")
	else: 
		animated_sprite.play("idle_close")
	
	if self.opened:
		self.timer += delta
	
	if self.timer > 15:
		breakpoint
		wall_grow()
		self.charge = 0
		self.timer = 0
		self.opened = false

func wall_grow():
	wall.hitbox.height = 64

func wall_ungrow():
	wall.hitbox.height = 0

