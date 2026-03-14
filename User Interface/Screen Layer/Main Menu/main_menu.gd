extends Control

signal play_button_pressed

#Start game (initialize first world)
func _on_play_button_pressed() -> void:
	Audio.ui_button_click()
	emit_signal("play_button_pressed")
	self.visible = false


#Open the settings menu
func _on_settings_button_pressed() -> void:
	print("Opening settings")
	Audio.ui_button_click()
	


#Exit the game
func _on_exit_button_pressed() -> void:
	Audio.ui_button_click()
	get_tree().quit()



#===Button Hover Sounds===
func _on_play_button_mouse_entered() -> void:
	Audio.ui_button_hover()

func _on_settings_button_mouse_entered() -> void:
	Audio.ui_button_hover()

func _on_exit_button_mouse_entered() -> void:
	Audio.ui_button_hover()
