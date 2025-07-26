@tool
@abstract class_name StatePda
extends State

var belong_state_machine: StateMachinePda

signal state_pushed() ## 状态推入信号
signal state_poped ## 当前状态推出信号

func _setup():
	for i in get_children():
		if i is StatePda:
			i.belong_state_machine = belong_state_machine
			i.state_poped.connect(belong_state_machine._on_state_poped)
			i.state_pushed.connect(belong_state_machine._on_state_pushed)
			i._setup()
