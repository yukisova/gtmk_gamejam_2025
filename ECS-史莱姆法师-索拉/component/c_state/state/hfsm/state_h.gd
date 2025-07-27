##@editing:	Sora
##@describe:	基于Hfsm的状态基类, 包含过渡与状态拥有者
@tool
@abstract class_name StateHfsm
extends State

signal state_transition(from: NodePath, keyword: StringName)
signal transition_finished

var parent_to_self: NodePath
var state_owner: Node

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		parent_to_self = get_parent().get_path_to(self)
		state_owner = owner
