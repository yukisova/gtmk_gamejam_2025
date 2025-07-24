class_name PlayerSpawn
extends Node2D

var current_level: Level

func _enter_tree() -> void:
	var parent = get_parent()
	if parent is Level:
		current_level = parent
	else:
		push_error("应当将玩家出生点放在指定层下！")
		
