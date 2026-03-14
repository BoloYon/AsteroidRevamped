extends DeathHandler

func init_death() -> void:
	#Any functions here
	get_body().queue_free()
