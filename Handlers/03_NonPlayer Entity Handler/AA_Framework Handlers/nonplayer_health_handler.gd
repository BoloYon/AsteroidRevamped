class_name NonPlayerHealthHandler
extends HealthHandler


#GOAL: TO handle all BASIC non-player health functions


func innit_health_bar() -> void:
	update_health_bar(_health, _max_health)


func show_health_bar():
	var health_bar:Control = get_body().health_bar
	if !health_bar.visible:
		health_bar.visible = true


func update_health_bar(health: float, max_health: float) -> void:
	#This is for damagable entities with a healthbar
	get_body().health_bar.set_value(health/ max_health * 100)


#In charge of decrementing health step by step
func step_decrement_health(delta: float) -> void:
	#If decrement health is not active, return
	if !get_body().decrement_health_active:
		return
	
	#This step decrement should ALWAYS take .1 seconds
	var rate: float = get_body().step_health_start/ 0.1
	
	#Set the healthbar and decrement set health
	update_health_bar((_health + get_body().step_health), _max_health)
	get_body().step_health -= rate * delta
	
	#When we finish stepping health, stop running this function
	if get_body().step_health <= 0:
		get_body().decrement_health_active = false
