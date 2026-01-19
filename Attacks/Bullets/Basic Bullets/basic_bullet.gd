class_name BasicBullet
extends Entity

var speed: float = 100

func _init() -> void:
	add_to_group("attacks")

func _physics_process(delta: float) -> void:
	#TODO: Add to movement handler
	self.position += Vector2.RIGHT.rotated(rotation) * speed * delta
	await get_tree().create_timer(10).timeout
	self.queue_free()

func group_to_parent(body: CharacterBody2D) -> void:
	add_to_group(str(body))
