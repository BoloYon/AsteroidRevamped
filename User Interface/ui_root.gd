extends CanvasLayer

#===Scene Manager===
@onready var scene_manager = get_parent().get_node("SceneManager")

#===Screen layer and its children===
@onready var screen_layer = $ScreenLayer
@onready var hud = $ScreenLayer/HUD
@onready var main_menu = $ScreenLayer/MainMenu

#===Popup layer and its children===
@onready var popup_layer = $PopupLayer

#===Decision layer and its children===
@onready var decision_layer = $DecisionLayer

var player: CharacterBody2D = null


#Connect all signals under UI Root
func _ready() -> void:
	main_menu.play_button_pressed.connect(_on_play_requested)


func _on_play_requested() -> void:
	scene_manager.main_menu_play_pressed()
	bind_player(scene_manager.player)


#===All functions player related===
#Connects new players to all UI elements after unbinding old player
func bind_player(new_player: CharacterBody2D) -> void:
	disconnect_all()
	player = new_player
	connect_all()

func disconnect_all() -> void:
	if player == null:
		return
	if !is_instance_valid(player):
		player = null
		return
	hud.unbind_player()
	
	#After all signals have been disconnected
	player = null

func connect_all() -> void:
	if player == null:
		return
	
	hud.bind_player(player)
