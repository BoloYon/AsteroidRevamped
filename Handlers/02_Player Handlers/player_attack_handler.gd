extends AttackHandler


signal attack_pressed


func attack_action_pressed(reload:float, bullet_speed:float) -> void:
	get_body().can_shoot = false
	player_shoot(bullet_speed, get_body().bulletSkins[0])
	attack_pressed.emit(reload)
	cooldown(reload)

#---Player Attacks---
func player_shoot(bullet_speed, bullet_skin):
	summon_bullet(bullet_speed, bullet_skin)
