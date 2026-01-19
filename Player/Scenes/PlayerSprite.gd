extends Sprite2D

#Any sprite animation or effects go here

var do_animation: bool

func when_ready(Collision) -> void:
	Collision.start_immunity_animation.connect(_on_immunity_start)
	Collision.end_immunity_animation.connect(_on_immunity_end)

func _on_immunity_start():
	do_animation = true
	while do_animation:
		self.visible = false
		await get_tree().create_timer(0.04).timeout
		self.visible = true
		await get_tree().create_timer(0.04).timeout

func _on_immunity_end():
	do_animation = false
