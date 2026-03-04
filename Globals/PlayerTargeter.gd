extends Node


var _player_position: Vector2


#The player sets this position
func set_player_position(position: Vector2) -> void:
	_player_position = position


#Gives the player position to those who call it
func get_player_position() -> Vector2:
	return _player_position
