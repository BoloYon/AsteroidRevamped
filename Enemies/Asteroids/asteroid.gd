class_name Asteroid
extends Entity

@onready var health_bar := $HealthBarBasic

@export var _max_health: float = 100
@export var _health: float = _max_health

func _ready() -> void:
	#Set the healthbar to the max health when first spawned
	health_bar.set_value(_health/ _max_health * 100)

func _process(delta: float) -> void:
	#TODO: Add to movement handler
	#Move the asteroid in the direction the sprite is facing
	position += Vector2.RIGHT.rotated($Sprite2D.rotation) * 90 * delta
