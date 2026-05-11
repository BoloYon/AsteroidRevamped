extends Control

var data: Dictionary

func show_with_data(d: Dictionary) -> void:
	data = d #Allows for data usage throughout script
	$Question.text = data["text"]
	self.show()

func _on_no_button_pressed() -> void:
	Audio.ui_button_click()
	data["on_no"].call()
	self.hide()

func _on_yes_button_pressed() -> void:
	Audio.ui_button_click()
	data["on_yes"].call()
	self.hide()

func _on_no_button_mouse_entered() -> void:
	Audio.ui_button_hover()

func _on_yes_button_mouse_entered() -> void:
	Audio.ui_button_hover()
