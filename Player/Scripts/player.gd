extends Entity

#Signals
signal attack_pressed

@onready var Movement = PlayerMovement.new()

@export var bulletSkins: Array[PackedScene]

#Upgradable Stats
@export var _speed: float
@export var _bullet_speed: float
@export var _reload: float

#Misc variables
var can_shoot: bool = true #Helps gate shoot action from firing unwantedly

func _ready() -> void:
	#Connect Movement
	Movement.set_body(self)
	
	print(Movement._body)
	print(Collision._body)
	print(Wrap._body)
	print(Attack._body)
	
	#Connect signals from those handlers
	Attack.cooldown_complete.connect(_on_cooldown_finished)
	
	#Prevents crashing when sprite is ready. Also connects this same collision object with sprite
	$Sprite2D.when_ready(Collision)
	

func _process(delta: float) -> void:
	#Movement
	Movement.player_look()
	Movement.player_move(_speed, delta)
	
	#Wrapping
	Wrap.wrap_screen()
	
	#Shooting
	if Input.is_action_pressed("Attack") and can_shoot:
		can_shoot = false
		Attack.player_shoot(_bullet_speed, bulletSkins[0])
		Attack.cooldown(_reload)


#Connected Signals
func _on_cooldown_finished():
	can_shoot = true

#Collision Detection
func _on_area_2d_area_entered(area: Area2D) -> void:
	#Send it to the collision handler
	Collision.handle(area)
