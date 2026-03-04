extends HandlerFramework


#Things to do on birth of child
func init() -> void:
	start_line_particles()


func start_line_particles():
	get_body().LineEffect.emitting = true
	calculate_line_gravity()

func calculate_line_gravity() -> void:
	get_body().LineEffect.process_material = get_body().LineEffect.process_material.duplicate()
	var mat := get_body().LineEffect.process_material as ParticleProcessMaterial
	var line_length = get_body().speed / 2
	mat.gravity = Vector3(0, line_length, 0)
