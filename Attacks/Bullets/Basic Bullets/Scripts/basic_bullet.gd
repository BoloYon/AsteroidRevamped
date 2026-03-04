class_name BasicBullet
extends Entity

#These are special handlers meant for specifically basic bullet. 
@onready var MasterHandler: Node = $MasterHandler #Master handler
@onready var Collision: Node = null
@onready var Particle: Node = null

#All particles
@onready var FireEffect = $Particles/FireEffect
@onready var LineEffect = $Particles/LineEffect


var speed: float = 1000


func _init() -> void:
	add_to_group("attacks")


func _ready() -> void:
	MasterHandler.init_children_handlers(self)


func _physics_process(delta: float) -> void:
	#TODO: Add to movement handler
	self.position += Vector2.RIGHT.rotated(rotation) * speed * delta
	#await get_tree().create_timer(10).timeout
	#self.queue_free()


#Called from player
func group_to_parent(body: CharacterBody2D) -> void:
	add_to_group(str(body))


#Special effects on collision
func _on_area_2d_area_entered(area: Area2D) -> void:
	#Gets the string name of the area's body
	var other_body = area.owner
	
	#if bullet not an ally w/ collider continue to bullet's collision handler
	if not self.is_ally(str(other_body)):
		Collision.on_collision()
