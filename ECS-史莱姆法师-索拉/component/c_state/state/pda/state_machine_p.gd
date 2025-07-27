##@editing:	Sora
##@describe:	栈状态机: 用于Ui交互与敌人的AI（目前对LimboAI存在保留意见，在AI不复杂的情况下没有使用的必要）
##			因为要实现栈的特性，需要有个头栈
@tool
class_name StateMachinePda
extends State

@onready var current_state = get_child(0)

func _setup() -> void:
	if get_child_count() > 1:
		push_error("PDA要求有且仅有一个直接子节点作为头栈方便进行状态机的运行")
		
	if current_state is StatePda:
		current_state.belong_state_machine = self
		current_state.state_pushed.connect(_on_state_pushed)
		current_state.state_poped.connect(_on_state_poped)
		current_state._setup()
	else:
		push_error("头栈不合法")

func _on_state_pushed(to_state: StatePda):
	if to_state.get_parent() == current_state:
		current_state._exit()
		current_state = to_state
		current_state._enter()
	else:
		push_error("被推入的状态必须是当前状态的子状态")

func _on_state_poped():
	if current_state.get_parent() != self:
		current_state._exit()
		current_state = current_state.get_parent()
		current_state._enter()

func _enter():
	current_state._enter()
	
func _fixed_update(delta: float) -> void:
	current_state._fixed_update(delta)

func _update(delta: float) -> void:
	current_state._update(delta)

func _get_active_state() -> StatePda:
	return current_state
