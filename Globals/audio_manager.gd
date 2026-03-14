extends Node

var sounds_ui := {
	"ui_button_hover": preload("res://Sounds/Global Sounds/MouseHoverButtonEvent.wav"),
	"ui_button_click": preload("res://Sounds/Global Sounds/GlobalButtonClick.wav")
}


@onready var ui_player: AudioStreamPlayer = AudioStreamPlayer.new()


func _ready() -> void:
	add_child(ui_player)

func ui_button_hover() -> void:
	var rand_num = _get_random(0.9, 1.1)
	ui_player.stream = sounds_ui["ui_button_hover"]
	ui_player.pitch_scale = rand_num
	ui_player.volume_db = -10.0
	ui_player.play()

func ui_button_click() -> void:
	var randnum = _get_random(0.8,1.2)
	var rand_num = _get_random(0.9, 1.1)
	ui_player.stream = sounds_ui["ui_button_click"]
	ui_player.pitch_scale = rand_num
	#ui_player.volume_db = -10.0
	ui_player.play()



#===Helper Functions===
func _get_random(min:float, max:float) -> float:
	return randf_range(min, max)
