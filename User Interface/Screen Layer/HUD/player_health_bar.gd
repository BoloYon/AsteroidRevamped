extends Control

@export var decrement_time_in_seconds = 0.15

@onready var bar = $Bar
@onready var label = $Bar/Label
 
var target_health : float
var health : float
var max_health : float
var rate : float

func _ready() -> void:
	set_process(false)

func step_health(old_health: float, current_health: float, max: float) -> void:
	target_health = current_health
	health = old_health
	max_health = max
	
	bar.max_value = max_health
	bar.value = health
	
	# Calculate how fast we should move
	var diff = old_health - current_health
	rate = diff / decrement_time_in_seconds
	
	set_process(true)

func _process(delta: float) -> void:
	health -= rate * delta
	
	if health <= target_health:
		health = target_health
		set_process(false)
	
	bar.value = health
	print_bar_text()


func print_bar_text() -> void:
	var left = health
	var right = max_health
	
	if left > 10 and right > 10:
		label.text = "%.0f/%.0f" % [health, max_health]
	elif left < 10 and right > 10:
		label.text = "%.2f/%.0f" % [health, max_health]
	elif right < 10:
		label.text = "%.2f/%.2f" % [health, max_health]
		
