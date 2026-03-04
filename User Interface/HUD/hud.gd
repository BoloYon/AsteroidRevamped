extends Control

@onready var health_ui = $PlayerHealthBar
@onready var reload_ui = $ReloadBar

var p: CharacterBody2D

#Binds player
func bind_player(player: CharacterBody2D) -> void:
	p = player
	_connect_player_signals()

func unbind_player(player: CharacterBody2D) -> void:
	_disconnect_player_singals()
	p = null

func _connect_player_signals() -> void:
	p.attack_pressed.connect(_on_attack_pressed)
	p.Health.health_changed.connect(_on_health_changed)
	_on_health_changed(p.Health.get_health(), p.Health.get_health(),p.Health.get_max_health())

func _disconnect_player_singals() -> void:
	p.attack_pressed.connect(_on_attack_pressed)
	p.Health.health_changed.connect(_on_health_changed)

#===Player Signal Functions===
func _on_attack_pressed() -> void:
	pass

#Called when health changes (+/-)
func _on_health_changed(old_health:float, current_health:float, max_health:float) -> void:
	#Calls the player's healthbar to step-decrement and show health
	health_ui.step_health(old_health, current_health, max_health)
