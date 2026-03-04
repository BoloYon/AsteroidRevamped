class_name LevelScript
extends Node2D

func get_player() -> CharacterBody2D:
	return get_node("Player")
