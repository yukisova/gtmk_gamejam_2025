## @editing: Sora [br]
## @describe: 谈话交互,绑定DialogueManager，此时玩家会被硬控，游戏状态机进入cutscene状态
##			HACK 谈话的对话框希望在ui_view中
extends InitiativeInteraction

@export var action_dialogue: Action

func _on_interact_activated(_component: IComponent):
	pass
	
func _on_interact_deactivated(_component: IComponent):
	pass
