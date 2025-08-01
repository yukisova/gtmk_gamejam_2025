extends ISystem

var sub_systems: Dictionary[StringName, SubSystem]

func _setup(): ## 系统初始化
	for i in get_children():
		if i is SubSystem:
			sub_systems[i.keyword] = i

func _process(delta: float) -> void:
	if SGameState.state_machine._get_active_state() is GamingChildStateMachine:
		for i in sub_systems.values():
			i._update(delta)
