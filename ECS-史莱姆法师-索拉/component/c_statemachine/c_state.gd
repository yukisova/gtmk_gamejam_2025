@tool
class_name C_Hfsm
extends IComponent

@export var root_state_machine: StateMachineHfsm

func _enter_tree() -> void:
	component_name = ComponentName.c_statemachine

func _initialize(_owner: Entity):
	super._initialize(_owner)
	
	root_state_machine._enter()
	root_state_machine._setup()

func _update(delta: float):
	root_state_machine._update(delta)

func _fixed_update(delta: float):
	root_state_machine._fixed_update(delta)
