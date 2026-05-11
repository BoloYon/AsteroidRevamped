extends Control

#All children nodes:
@onready var HUD: Control = $HUD
@onready var DeathScreen: Control = $DeathScreen
@onready var MainMenu: Control = $MainMenu

var player: CharacterBody2D = null

#==Bindings===
#---Binds to signals---
func _ready() -> void:
	pass
	
#---Binds itself and children to the current player---
func bind_player(p:CharacterBody2D) -> void:
	player = p
	bind_all_to_player()

func unbind_player() -> void:
	unbind_all_from_player()
	player = null

#Binds player to select children that require player details
func bind_all_to_player() -> void:
	HUD.bind_player(player)

func unbind_all_from_player() -> void:
	HUD.unbind_player(player)



#===Death screen functions===
func show_death_screen() -> void:
	DeathScreen.start_animation()
