extends CanvasLayer

#===Scene Manager===
@onready var SceneManager:Node = get_parent().get_node("SceneManager")

#===Screen layer and its children===
@onready var ScreenLayer:Control = $ScreenLayer

#===Popup layer and its children===
@onready var PopupLayer:Control = $PopupLayer

#===Decision layer and its children===
@onready var DecisionLayer:Control = $DecisionLayer

var player: CharacterBody2D = null


#Connect all signals under UI Root
func _ready() -> void:
	ScreenLayer.MainMenu.play_button_pressed.connect(_on_play_requested)


func _on_play_requested() -> void:
	SceneManager.main_menu_play_pressed()
	bind_player(SceneManager.player)


#===All functions player related===
#---Bindings and Unbindings of players---
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
	ScreenLayer.unbind_player()
	
	#After all signals have been disconnected
	player = null

func connect_all() -> void:
	if player == null:
		return
	
	ScreenLayer.bind_player(player)

#---Player death---
func request_death_screen() -> void:
	ScreenLayer.show_death_screen()
