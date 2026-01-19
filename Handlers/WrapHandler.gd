class_name WrapHandler
extends BASEHANDLER

func wrap_screen() -> void:
	#Get the viewport's visibility rectangle
	var root = _body.get_tree().root
	var rect = root.get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x
	var right = rect.position.x + rect.size.x
	var up = rect.position.y
	var down = rect.position.y + rect.size.y
	
	#Define the player's positios
	var player_pos = _body.position
	
	#Actual screen wrapping code
	if player_pos.x < left: #if the player's position goes passed the left size...
		player_pos.x = right#... teleport the player to the right with the same y axis
	if player_pos.x > right:
		player_pos.x = left
	if player_pos.y < up:
		player_pos.y = down
	if player_pos.y > down:
		player_pos.y = up
		
	#Set the position
	_body.position = player_pos
