extends Node2D

func _input(event: InputEvent) -> void:
	#Escape if escape is pressed
	if(Input.is_action_pressed("Escape")):
		get_tree().quit()
