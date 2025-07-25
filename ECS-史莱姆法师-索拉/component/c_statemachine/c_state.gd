@tool
class_name C_State
extends IComponent

@export var root_state_machine: StateMachineHfsm
@export var ai_state_machine: StateMachinePda

func _enter_tree() -> void:
	component_name = ComponentName.c_state

func _initialize(_owner: Entity):
	super._initialize(_owner)
	
	if root_state_machine:
		root_state_machine._enter()
		root_state_machine._setup()
	if ai_state_machine:
		ai_state_machine._enter()
		ai_state_machine._setup()

func _update(_delta: float):
	if root_state_machine:
		root_state_machine._update(_delta)
	if ai_state_machine:
		ai_state_machine._update(_delta)

func _fixed_update(_delta: float):
	if root_state_machine:
		root_state_machine._fixed_update(_delta)
	if ai_state_machine:
		ai_state_machine._update(_delta)
