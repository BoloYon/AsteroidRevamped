class_name Spawner
extends Node2D


@export var cooldown: float
@export var margin: float = 300
@export var Asteroid_Scene: PackedScene


var is_ready: bool = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	look_at_player()
	if is_ready:
		is_ready = false
		teleport_to_new_location(margin)
		look_at_player()
		spawn_new_asteroid()


func teleport_to_new_location(margin: float) -> void:
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x - margin
	var right = rect.position.x + rect.size.x + margin
	var up = rect.position.y - margin
	var down = rect.position.y + rect.size.y + margin
	
	#Make an array to randomly choose a number which corresponds to one of the directions
	var directions = ["left", "right", "up", "down"]
	match directions[randi_range(0,3)]:
		"left":
			var rand = randf_range(up, down)
			self.position = Vector2(left, rand)
		"right":
			var rand = randf_range(up, down)
			self.position = Vector2(right, rand)
		"up":
			var rand = randf_range(left, right)
			self.position = Vector2(rand, up)
		"down":
			var rand = randf_range(left, right)
			self.position = Vector2(rand, down)

func spawn_new_asteroid() -> void:
	var asteroid = Asteroid_Scene.instantiate()
	asteroid.position = self.position
	#asteroid.max_health = 1.5 + 5 #* pow(GameManager.wave, 1.25) #Base health * multiplier
	#asteroid.size = randf_range(0.04, 0.12) #0.4-0.12
	asteroid.set_sprite_rotation(self.rotation_degrees)
	asteroid.accel = randf_range(100,340)
	#asteroid.Damage = 5 + 1.5 #* pow(GameManager.wave, 1.43)
	asteroid.add_to_group("regular asteroid")
	get_parent().add_child(asteroid)
		
	#Spawn Cooldown
	await get_tree().create_timer(cooldown).timeout
	is_ready = true
	decrease_spawn_speed()

func decrease_spawn_speed() -> void:
	var min_speed = 0.5
	var multiplier = max(0.5, 0.99  )#- (GameManager.wave * 0.01))
	cooldown = max(min_speed, cooldown * multiplier)
	print(cooldown)

func look_at_player() -> void:
	look_at(PlayerTargeter.get_player_position())
