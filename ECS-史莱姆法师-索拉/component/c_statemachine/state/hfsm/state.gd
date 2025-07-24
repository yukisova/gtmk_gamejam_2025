@tool
@abstract class_name State
extends Node

signal state_transition(from: NodePath, _keyword: StringName)
signal transition_finished


const DefaultKeyword : StringName = "EVENT_FINISHED"

var parent_to_self: NodePath
var state_owner: Entity

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		parent_to_self = get_parent().get_path_to(self)
		state_owner = owner as Entity

func _enter():
	pass

func _update(_delta: float) -> void:
	_listen()

func _fixed_update(_delta: float) -> void:
	pass

func _exit():
	pass

func _listen(): ## 用于部分状态下的按键监听
	pass
