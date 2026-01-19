extends Control

@onready var _health_bar = $Bar

#Set value - Changes the green on the progress bar
func set_value(val: float) -> void:
	_health_bar.value = val
