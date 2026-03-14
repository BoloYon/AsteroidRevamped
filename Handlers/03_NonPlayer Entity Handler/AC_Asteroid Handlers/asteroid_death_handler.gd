extends DeathHandler

var p1:GPUParticles2D
var p2:GPUParticles2D
var p3:GPUParticles2D


#Overwrite parent function
func init_death() -> void:
	#Avoids null bodies
	_set_particle_paths()
	
	#Timer to await healthbar to deplete
	await get_tree().create_timer(0.1).timeout
	
	#The particle "animations"
	_explode_particles()
	
	#Set the whole body free
	get_body().queue_free()


func _set_particle_paths() -> void:
	p1 = get_body().get_node("ParticleMaster/Shards_1")
	p2 = get_body().get_node("ParticleMaster/Shards_2")
	p3 = get_body().get_node("ParticleMaster/Shards_3")


func _explode_particles():
	var p_arr := [p1,p2,p3]
	
	for p:GPUParticles2D in p_arr:
		p.reparent(get_tree().current_scene)
		p.global_position = get_body().global_position
		p.emitting = true
	
