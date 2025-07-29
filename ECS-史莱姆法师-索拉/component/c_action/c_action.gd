## @editing: Sora [br]
## @describe: 指定Entity所可能出现的行为的具体逻辑，以模组的方式进行绑定，如死亡掉落。[br]
## 				潜力：可以定义玩家的一些特殊动作，并使用InputListener进行激活
@tool
class_name C_Action
extends IComponent

signal _action_searched

func _enter_tree() -> void:
	component_name = ComponentName.c_action

func _initialize(_owner: Entity):
	super(_owner)
	
	for i: Action in get_children():
		i.c_action = self
