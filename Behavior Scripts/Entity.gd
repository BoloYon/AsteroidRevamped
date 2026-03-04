class_name Entity
extends CharacterBody2D

#Includes basic behaviors for all entities (projectile attacks, enemies, players, etc.)


#Booleans that give entities specific tags (set in inspector)
@export var can_attack: bool = false
@export var has_health: bool = false
@export var can_collide: bool = false
@export var can_die: bool = false #Like training dummies to see dmg output (if I ever implement it lol)


#Actual game variables:
@export var _base_body_damage = 0.0 #Used in determining how much damage an entity will do without mutlipliers


#===Getters===
func get_base_body_damage() -> float:
	return _base_body_damage

#---Getters for entity tags. Used for checking if we can run certain functions under specific entities---
func get_health_bool() -> bool:
	return has_health
func get_attack_bool() -> bool:
	return can_attack
func get_collide_bool() -> bool:
	return can_collide
func get_die_bool() -> bool:
	return can_die

func set_body_base_damage(new_body_damage: float) -> void:
	_base_body_damage = new_body_damage


func is_ally(body_name: String) -> bool:
	return is_in_group(body_name)
