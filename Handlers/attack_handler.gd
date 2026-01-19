class_name AttackHandler
extends BASEHANDLER

signal cooldown_complete

#===Bullets===
func summon_bullet(bullet_speed, bullet_skin):
	#Tweak bullet settings
	var bullet = bullet_skin.instantiate()
	bullet.position = _body.position
	bullet.rotation = _body.rotation
	bullet.speed = bullet_speed
	
	#Add bullet to its parent's group to avoid self fire
	bullet.group_to_parent(_body)
	
	#Add bullet to scene
	_body.get_parent().add_child(bullet)

#Prevents shooter from overfiring. Handles varying cooldowns
func cooldown(reloadSpeed: float):
	await _body.get_tree().create_timer(reloadSpeed).timeout
	emit_signal("cooldown_complete")

#---Player Attakcs---
#Player makes bullet exists. Therefore, call summon bullet from player
func player_shoot(bullet_speed, bullet_skin):
	summon_bullet(bullet_speed, bullet_skin)

#===Helper Functions===
