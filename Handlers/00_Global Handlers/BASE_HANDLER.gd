class_name BASEHANDLER
extends Node

var _body: CharacterBody2D

#Links handler to body that calls on it
func set_body(Body: CharacterBody2D):
	_body = Body

func get_body() -> CharacterBody2D:
	return _body
