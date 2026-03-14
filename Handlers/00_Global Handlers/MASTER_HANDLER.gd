class_name MasterHandler
extends BASEHANDLER

func init_children_handlers(player: CharacterBody2D) -> void:
	for child in get_children():
		child.init_self(player)
	
