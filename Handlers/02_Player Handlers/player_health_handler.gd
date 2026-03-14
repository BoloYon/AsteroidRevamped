extends HealthHandler

func immunity(body: CharacterBody2D) -> void:
	if !get_health() <= 0:
		can_be_hit = false
		start_immunity_animation.emit()
		await body.get_tree().create_timer(1).timeout #Duration of the immunity frames
		can_be_hit = true
		end_immunity_animation.emit()
