extends CollisionHandler

func on_collision() -> void:
	do_fire_effect()
	

func init() -> void:
	pass

func do_fire_effect() -> void:
	calc_fire_init_vel()
	get_body().FireEffect.emitting = true

func calc_fire_init_vel():
	get_body().FireEffect.process_material = get_body().FireEffect.process_material.duplicate()
	var mat := get_body().FireEffect.process_material as ParticleProcessMaterial

	mat.initial_velocity_min = get_body().speed * 1
	mat.initial_velocity_max = get_body().speed * 1
