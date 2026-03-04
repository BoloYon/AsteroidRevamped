extends Node


@export var current_world: String

var world_node: Node
var player: CharacterBody2D = null


func main_menu_play_pressed() -> void:
	var scene = preload("res://Levels/Level1.tscn")
	world_node = scene.instantiate()
	_instance_world()
	_bind_world()


#Goal: When called, will free current scene, switch to given scene, and run other helper functions
func change_world(world_path: String) -> void:
	#Current world will never be null. No need for checks.
	var scene: PackedScene = load(current_world)
	
	#Free current scene
	_unload_current_world()
	
	#Change current world path to the new one
	current_world = world_path
	scene = load(current_world)
	world_node = scene.instantiate()
	
	#Add new scene to tree
	_instance_world()
	
	#Helper functions
	_bind_world()


func _unload_current_world() -> void:
	world_node.queue_free()


func _instance_world() -> void:
	$WorldRoot.add_child(world_node)


func _bind_world() -> void:
	player = world_node.get_player()
