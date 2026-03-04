class_name HealthHandler
extends HandlerFramework


signal start_immunity_animation
signal end_immunity_animation
signal health_changed


var _health: float = -1.0
var _max_health: float = -1.0
var is_dead: bool = false
var can_be_hit: bool = true


#Handles health logic and damage logic. Communicates with healthbar
func boot_up() -> void:
	is_health_valid()

#Getters
func get_max_health() -> float:
	return _max_health

func get_health() -> float:
	return _health


#Setters
func set_max_health(new_max: float) -> void:
	#Goal: Update max health and add/ subtract accordingly to regular health
	var difference = get_health_difference()
	_max_health = new_max
	if difference >= 0:
		heal(difference)
	else:
		damage(difference)

func set_health(new_current_health) -> void:
	var old_health = _health #Save previous health (used for HUD step-decrement/ increment)
	_health = new_current_health
	health_changed.emit(old_health, get_health(), get_max_health())


#Throws an error when health values go below 0 upon instantializing. Also clips health to max health
func is_health_valid() -> void:
	if _health < 0 or _max_health < 0:
		assert(false, "Health or Max Health is negative for EntityDamagable class.")
	if _max_health < _health:
		_health = _max_health


#Use this function whenever health is added
func heal(heal_amount: float) -> void:
	var old_health = _health #Save previous health (used for HUD step-decrement/ increment)
	_health = clampf(_health + heal_amount, 0, _max_health)
	#Send signal
	health_changed.emit(old_health, get_health(), get_max_health())


#Use this function whenever damage is taken
func damage(damage_amount: float) -> void:
	var old_health = _health #Save previous health (used for HUD step-decrement/ increment)
	_health = clampf(_health - damage_amount, 0, _max_health)
	health_changed.emit(old_health, get_health(), get_max_health())
	if _health == 0:
		innit_death()


#Get's the difference between max and current health
func get_health_difference() -> float:
	return get_max_health() - get_health()


#Used to play a death animation or wait to be deleted
func innit_death() -> void:
	await get_body().get_tree().create_timer(0.1).timeout
	get_body().queue_free()
