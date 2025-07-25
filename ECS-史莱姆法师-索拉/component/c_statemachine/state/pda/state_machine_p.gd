## 栈状态机: 
@tool
class_name StateMachinePda
extends State

@export_node_path() var init_state: NodePath:
	set(value):
		if value.is_empty():
			init_state = NodePath()
			return
			
		# 校验路径深度：直接子节点路径格式应为 "子节点名"
		if value.get_name_count() != 1:
			push_error("目标节点必须是直接子节点！")
			return
			
		init_state = value
	get:
		
		if get_child_count() == 0:
			#push_error("状态机 %s没有状态用于初始化" % [name])
			return ""
		elif init_state == null:
			return get_path_to(get_child(0))
		else:
			return init_state
#
var current_state: StatePda
#
func _setup() -> void:
	for i in get_children():
		if i is StatePda:
			i.state_pushed.connect(_on_state_pushed)
			i.state_poped.connect(_on_state_poped)
		if i is StateMachinePda:
			i._setup()

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
	current_state = get_node(init_state)
	current_state._enter()
#
func _fixed_update(delta: float) -> void:
	current_state._fixed_update(delta)

func _update(delta: float) -> void:
	super._update(delta)
	current_state._update(delta)

func _get_active_state() -> StatePda:
	return current_state
