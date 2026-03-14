extends Node

@onready var SceneManager: Node = get_parent()

var Player: CharacterBody2D = null
var slowmo_tween: Tween

#===Binding/Unbindings===
#--Player--
func bind_player(p: CharacterBody2D) -> void:
	Player = p
	connect_player_signals()
	print("Player bound to world root!")

func unbind_player() -> void:
	disconnect_player_signals()
	Player = null

func connect_player_signals() -> void:
	Player.Health.is_dead.connect(_on_player_death)

func disconnect_player_signals() -> void:
	Player.Health.is_dead.disconnect(_on_player_death)


#Functions from connected signals
func _on_player_death() -> void:
	do_pre_death()
	SceneManager.request_death_screen()

func _exit_tree() -> void:
	Engine.time_scale = 1.0


#===Helper Functions===
func slowmo_to(target: float, duration: float) -> void:
	slowmo_tween = create_tween()
	slowmo_tween.tween_property(Engine, "time_scale", target, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

func do_pre_death() -> void:
	#Slowmo simulation -> wait 1 second -> actually pause then reset engine back to normal
	slowmo_to(0.05, 0.25)
	await get_tree().create_timer(1.0, true, false, true).timeout
	slowmo_tween.kill()
	get_tree().paused = true
	Engine.time_scale = 1
