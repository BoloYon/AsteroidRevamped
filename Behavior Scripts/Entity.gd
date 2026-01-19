class_name Entity
extends CharacterBody2D

#Includes basic behaviors for all entities (projectile attacks, enemie, players, etc.)

#Find out what the entity can do. Movement is defined in the subclasses as there are mutiple movement subhandlers
@export var can_attack: bool = false
@export var can_collide: bool = false
@export var can_wrap: bool = false

#Connect Handler Objects to Entity (small one time memory cost)
@onready var Attack = AttackHandler.new()
@onready var Collision = CollisionHandler.new()
@onready var Wrap = WrapHandler.new()

func _ready() -> void:
#Allows use of handler functions
	print(Attack, can_attack)
	if can_attack:
		Attack.set_body(self)
	if can_collide:
		Collision.set_body(self)
	if can_wrap:
		Wrap.set_body(self)
