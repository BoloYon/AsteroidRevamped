extends Control


@onready var bar_left = $BarLeft
@onready var bar_right = $BarRight

var reload_time: float
var bar_value:float

func _ready() -> void:
	set_process(false)


func on_player_shoot(r:float) -> void:
	reload_time = r
	reset_bars()
	set_process(true)

func _process(delta: float) -> void:
	#How much we increase value every "process"
	var increment_amt = delta * reload_time
	
	bar_left.max_value = reload_time
	bar_right.max_value = reload_time
	
	bar_left.value += increment_amt
	bar_right.value += increment_amt
	bar_value += increment_amt
	
	if bar_value >= reload_time:
		bar_left.value = reload_time
		bar_right.value = reload_time
		set_process(false)
		print("Reloaded")

func reset_bars() -> void:
	bar_left.value = 0.0
	bar_right.value = 0.0
	bar_value = 0.0
