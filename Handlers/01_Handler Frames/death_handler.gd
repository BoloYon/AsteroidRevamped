class_name DeathHandler
extends HandlerFramework

func init_death() -> void:
	await get_body().get_tree().create_timer(0.1).timeout
	get_body().queue_free()
