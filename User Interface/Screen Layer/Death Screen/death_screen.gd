extends Control


@onready var red_vignette = $RedVignette
@onready var header = $CenterContainer/VBoxContainer/SimFail
@onready var death_box = $CenterContainer
@onready var bg_fade = $BGFade


func start_animation() -> void:
	visible = true
	await animate_red_vignette(1.0)
	await animate_death_box(0.1)
	await type_header("SIMULATION TERMINATED", 0.05)
	await appear_subheaders(0.5, 0.2)


#Fades in the red border
func animate_red_vignette(duration:float) -> void:
	var t: Tween = create_tween()
	t.tween_property(red_vignette, "modulate:a", 50.0/255.0 , duration)\
		.set_trans(Tween.TRANS_LINEAR)#\
		#.set_ease(Tween.EASE_OUT)
	await t.finished
	t.kill()

#Types out the header
func type_header(text:String, delay) -> void:
	header.text = ""
	
	for i in text.length():
		header.text = text.substr(0, i) + "|"
		await wait(delay)
		play_type()
	
	header.text = text

#Animate deathbox intro
func animate_death_box(duration:float) -> void:
	var t: Tween = create_tween().set_parallel()
	
	#Grow death box
	t.tween_property(death_box, "scale", Vector2(1,1), duration)
	#Grow background box and modulate too
	t.tween_property(bg_fade, "scale", Vector2(1,1), duration)
	t.tween_property(bg_fade, "modulate:a", 200.0/255.0 ,duration - 0.1)
	
	await t.finished
	play_terminal_open()
	await wait(0.1)

#Show subheaders and texts popping up
func appear_subheaders(subhead_dur: float, text_dur:float ) -> void:
	var mats_label = $CenterContainer/VBoxContainer/MatsExt
	var glint_label = $CenterContainer/VBoxContainer/Glintcores
	var space = $CenterContainer/VBoxContainer/SPACE
	
	var run_label = $CenterContainer/VBoxContainer/RunStats
	var astry_label = $CenterContainer/VBoxContainer/AstryAmt
	var meteor_label = $CenterContainer/VBoxContainer/MeteorAmt
	var wave_label = $CenterContainer/VBoxContainer/WaveAmt
	
	var end_border = $CenterContainer/VBoxContainer/EndBorder
	var button_box = $CenterContainer/VBoxContainer/HBoxContainer
	
	await wait(subhead_dur)
	mats_label.visible = true
	play_terminal_popup()
	
	await wait(text_dur)
	glint_label.visible = true
	space.visible = true
	play_terminal_popup()
	
	await wait(subhead_dur)
	run_label.visible = true
	play_terminal_popup()
	await wait(text_dur)
	astry_label.visible = true
	play_terminal_popup()
	await wait(text_dur)
	meteor_label.visible = true
	play_terminal_popup()
	await wait(text_dur)
	wave_label.visible = true
	play_terminal_popup()
	
	await wait(subhead_dur)
	end_border.visible = true
	button_box.visible = true
	play_terminal_popup()


#===Listen for button presses

#===Helper Function===
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func play_type() -> void:
	$TypeSound.pitch_scale = randf_range(0.8,1.2)
	$TypeSound.play()
func play_terminal_open() -> void:
	$TerminalOpen.play()
func play_terminal_popup() -> void:
	$TerminalPopup.pitch_scale = randf_range(0.8,1.1)
	$TerminalPopup.play()


#===Button Related Functions
#---Hover sounds---
func _on_rerun_sim_mouse_entered() -> void:
	Audio.ui_button_hover()

func _on_exit_sim_mouse_entered() -> void:
	Audio.ui_button_hover()

#---On Pressed---
func _on_rerun_sim_pressed() -> void:
	$RerunPressed.play()
	#Some function here - Basically just restart world
	print("Restarting Simulation...")

func _on_exit_sim_pressed() -> void:
	$ExitPressed.play()
	#Some function here - Take to UI menu 
	print("Exiting Simulation, rerouting to overview window")
