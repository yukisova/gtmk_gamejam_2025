@tool
@abstract class_name StateHfsm
extends State

signal state_transition(from: NodePath, _keyword: StringName)
signal transition_finished

const DefaultKeyword : StringName = "EVENT_FINISHED"

var parent_to_self: NodePath
var state_owner: Entity

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		parent_to_self = get_parent().get_path_to(self)
		state_owner = owner as Entity
