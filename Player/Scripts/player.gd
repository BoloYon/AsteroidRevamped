extends EntityDamagable



@export var bulletSkins: Array[PackedScene]


#Upgradable Stats
@export var _speed: float
@export var _bullet_speed: float
@export var _reload: float


#Handlers
@onready var MasterHandler: Node = $MasterHandler
var Movement: Node
var Collision: Node
var Wrap: Node
var Attack: Node
var Health: Node
var Death: Node

#Misc variables
var can_shoot: bool = true #Helps gate shoot action from firing unwantedly


func _ready() -> void:
	#Connects handlers (Entity Script)
	MasterHandler.init_children_handlers(self)
	
	
	#Connect signals
	Health.is_dead.connect(_on_death)
	
	#Connects health handler to sprite for immunity animations (may change later)
	$Sprite2D.when_ready(Health)
	
	#Innit health values:
	Health.set_max_health(101)
	Health.set_health(101)
	
	#Stops the game when starting health is invalid
	Health.is_health_valid()


func _process(delta: float) -> void:
	#Movement
	Movement.player_look()
	Movement.player_move(_speed, delta)
	
	#Wrapping
	Wrap.wrap_screen()
	
	#Shooting
	if Input.is_action_pressed("Attack") and can_shoot:
		Attack.attack_action_pressed(_reload, _bullet_speed)
	
	#Emmiting player position to PlayerTargeter global script (for enemy and spawner uses)
	PlayerTargeter.set_player_position(self.position)


#Collision Detection
func _on_area_2d_area_entered(area: Area2D) -> void:
	#Send it to the collision handler
	Collision.handle(area)

#Death Detection
func _on_death() -> void:
	Death.init_death()
