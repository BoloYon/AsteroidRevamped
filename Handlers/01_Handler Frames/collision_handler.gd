class_name CollisionHandler
extends HandlerFramework


#Handles collision 

signal was_damaged


func handle(foreign_area: Area2D) -> void:
	#Get the body of the area first
	var foreign_body = foreign_area.owner
	var body_name = str(get_body())
	
	#If the area that hits the body is not from itself or allies, and the body can be hit...
	if not foreign_body.is_ally(body_name) and get_body().Health.can_be_hit:
		damage_body(get_body(), foreign_body)
		#Undergo immunity frames if player is damaged
		if get_body().name == "Player":
			get_body().Health.immunity(get_body())


func damage_body(this_body: CharacterBody2D, foreign_body: CharacterBody2D) -> void:
	if this_body.get_health_bool():
		var future_health = this_body.Health.get_health() - foreign_body.get_base_body_damage()
		emit_signal("was_damaged", this_body.Health.get_health(), future_health)
		this_body.Health.damage(foreign_body.get_base_body_damage())
		print(this_body.Health.get_health())
		
