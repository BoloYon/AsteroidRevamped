extends Control

signal play_button_pressed

#Start game (initialize first world)
func _on_play_button_pressed() -> void:
	emit_signal("play_button_pressed")
	self.visible = false


#Open the settings menu
func _on_settings_button_pressed() -> void:
	print("Opening settings")


#Exit the game
func _on_exit_button_pressed() -> void:
	get_tree().quit()
