class_name BASEHANDLER
extends RefCounted

var _body: CharacterBody2D

#Links handler to body that calls on it
func set_body(Body: CharacterBody2D):
	_body = Body
