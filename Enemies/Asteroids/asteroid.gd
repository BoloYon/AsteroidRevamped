class_name Asteroid
extends EntityDamagable


@onready var health_bar := $HealthBarBasic

#Handler Variables
@onready var HandlerMaster: Node = $HandlerMaster
var Collision: Node = null
var Health: Node = null
var Death: Node = null

var accel: float
var step_health: float
var step_health_start: float
var decrement_health_active: float = false


func _ready() -> void:
	#Connect all active handlers
	HandlerMaster.init_children_handlers(self)
	
	#Connect signals
	Collision.was_damaged.connect(_on_hit)
	Health.is_dead.connect(_on_death)
	
	#Avoids asteroids damaging eachother
	add_to_group("enemy")
	
	#Innit health values:
	Health.set_max_health(500)
	Health.set_health(500)
	
	#Update the healthbar when first spawning
	Health.innit_health_bar()
	
	#Stops the game when health is invalid and clamps health to max_health (if health is above max)
	Health.is_health_valid()
	
	Health.boot_up()

func _process(delta: float) -> void:
	#When activated via on_hit function, will decrement health step by step
	Health.step_decrement_health(delta)
	#TODO: Add to movement handler
	#Move the asteroid in the direction the sprite is facing
	position += Vector2.RIGHT.rotated($Sprite2D.rotation) * 90 * delta


#Called by the spawner to set the sprite's rotation
func set_sprite_rotation(spawner_rotation) -> void:
	$Sprite2D.rotation_degrees = (spawner_rotation + randf_range(-100,100)) #Slight and random offset to avoid constant targeting


func _on_area_2d_area_entered(area: Area2D) -> void:
	#Send it to the collision handler
	Collision.handle(area)


#Sets global variables to activate update_health_bar_on_hit in process function
func _on_hit(old_health, current_health) -> void:
	if !health_bar.visible:
		Health.show_health_bar()
	step_health_start = old_health - current_health
	step_health = step_health_start
	decrement_health_active = true

func _on_death() -> void:
	Death.init_death()
