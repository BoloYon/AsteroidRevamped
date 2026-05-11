extends Control

signal exit_sim_requested
signal decision_made #Used to let decisionlayer know when to hide itself again

#Data for decision layer
var data = {
	"type": "confirm",
	"text": "Are you sure you want to exit the simulation?",
	"on_yes": Callable(self, "_confirm_exit"),
	"on_no": Callable(self, "_cancel_exit")
}
#Variables
@onready var side_box: ColorRect = $SideEntryBox
@onready var bar_bg: ColorRect = $SideBarBG
@onready var container: VBoxContainer = $ButtonContainer
@onready var lock_button: TextureButton = $ButtonContainer/LockButton


@export var tween_delay: float = 0.1

var closed_pos_x: float
var open_pos_x: float
var locked: bool
var awaiting_tween: bool

#===SHOWING/ HIDING SIDEBAR===
func _on_side_entry_box_mouse_entered() -> void: #When the mouse touches the side box, remove the box and tween container 
	if !awaiting_tween:
		show_side_bar()

func _on_button_container_mouse_exited() -> void:
	if !locked and !awaiting_tween:
		hide_side_bar()

func show_side_bar() -> void:
	#Hide side box
	side_box.visible = false
	
	#Allow multiple tweens at once
	var t: Tween = create_tween().set_parallel()
	
	#Move nodes
	awaiting_tween = true
	var target = calculate_pos_x(bar_bg.position.x, -bar_bg.size.x) #Negative size because we are moving left on X axis for opening tween
	t.tween_property(bar_bg, "position:x", target, tween_delay)
	t.tween_property(container, "position:x", target, tween_delay ) #Container should always have the same size as bar_bg
	
	#Cooldown to avoid spamming open and close
	await t.finished
	awaiting_tween = false

func hide_side_bar() -> void:
	var t: Tween = create_tween().set_parallel()
	
	#Move Nodes
	awaiting_tween = true
	var target = calculate_pos_x(bar_bg.position.x, bar_bg.size.x)
	t.tween_property(bar_bg, "position:x", target, tween_delay)
	t.tween_property(container, "position:x", target, tween_delay)
	
	#Cooldown
	await t.finished
	side_box.visible = true
	awaiting_tween = false

func calculate_pos_x(curr_pos, size_x) -> float: #Allows for dynamic calculation if a screen changes sizes, returns target position
	return curr_pos + size_x


#===LOCKING LOGIC FOR SIDEBAR===
func _on_lock_button_pressed() -> void:
	if !locked:
		locked = true
		lock_button.tooltip_text = "Unlock sidebar"
	else: 
		locked = false
		lock_button.tooltip_text = "Lock sidebar"


#===EXIT SIMULATION BUTTON LOGIC===
func _on_exit_sim_pressed() -> void:
	#Pause game
	get_tree().paused = true
	#Emit signal to screenlayer
	exit_sim_requested.emit(data)

func _cancel_exit() -> void:
	#Resume game
	get_tree().paused = false
	decision_made.emit()

func _confirm_exit() -> void:
	#Would normally return to another menu, not exit game
	get_tree().quit()
	decision_made.emit()
