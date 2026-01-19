class_name CollisionHandler
extends BASEHANDLER

#Handles collision effects (like damage) and also immunity frames
####Note: _body var is in super parent class "BASEHANDLER"####

signal start_immunity_animation
signal end_immunity_animation

var can_be_hit: bool = true

func handle(foreign_area: Area2D) -> void:
	#Get the body of the area first
	var foreign_body = foreign_area.owner
	
	#If the area that hits the body is not from itself or allies, and the body can be hit...
	if not foreign_body.is_in_group(str(_body)) and can_be_hit:
		#damage hit body,
		print("HIT the ", _body.name)
		#and Undergo immunity frames if the one being hit is the player
		if _body.name == "Player":
			can_be_hit = false
			immunity()

func immunity() -> void:
	emit_signal("start_immunity_animation")
	await _body.get_tree().create_timer(1).timeout #Duration of the immunity frames
	can_be_hit = true
	emit_signal("end_immunity_animation")
	
