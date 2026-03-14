class_name HandlerFramework
extends BASEHANDLER

#GOAL: Dynamically sets the parameters of the entity's script by using its own name and the premade variables in said entity
	#TLDR: Player.HandlerType = self

func init_self(entity: CharacterBody2D) -> void:
	var title = get_handler_title()
	entity.set(title, self)
	set_body(entity)


#Gets the first half of the CamelCased name for itself (Health from HealthHandler)
func get_handler_title() -> String:
	var count_down: int = 1
	var str_builder: String = ""
	var name: String = str(self.name)
	
	#For every letter in name,
	for letter in name:
		#Look for a capital letter (after the first one) and stop building the string when it finishes
		if is_upper(letter):
			if count_down == 0:
				break
			count_down -= 1
		str_builder += letter
	
	return str_builder


#Helper Functions for MY understanding
func is_upper(letter: String) -> bool:
	return letter == letter.to_upper()
