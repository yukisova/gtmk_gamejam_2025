## @editing: Sora [br]
## @describe: 主动交互逻辑的基类, 将原本触发的基础改为允许待触发与中止待触发
@abstract class_name InitiativeInteraction
extends PassiveInteraction

## 中止待触发的逻辑
@abstract func _on_interact_deactivated(_component: IComponent)
