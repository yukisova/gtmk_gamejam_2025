extends Action

@export var test_dialogue_ui: PackedScene
@export var test_dialogue: DialogueResource
@export var test_dialogue_label: StringName
func _effect(..._args):
	var dialogue = SUiSpawner._spawn_ui(test_dialogue_ui)
	DialogueManager._start_balloon(dialogue, test_dialogue, test_dialogue_label, [])
