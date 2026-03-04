class_name AttackHandler
extends HandlerFramework

signal cooldown_complete


#GOAL: Handles bullet skins and the actual summoning of attacks

#===Bullets===
func summon_bullet(bullet_speed, bullet_skin):
	#Tweak bullet settings
	var bullet = bullet_skin.instantiate()
	bullet.position = get_body().position
	bullet.rotation = get_body().rotation
	bullet.speed = bullet_speed
	
	#Add bullet to its parent's group to avoid self fire
	bullet.group_to_parent(get_body())
	
	#Add bullet to scene
	get_body().get_parent().add_child(bullet)


#Prevents shooter from overfiring. Handles varying cooldowns
func cooldown(reloadSpeed: float):
	await get_body().get_tree().create_timer(reloadSpeed).timeout
	get_body().can_shoot = true
