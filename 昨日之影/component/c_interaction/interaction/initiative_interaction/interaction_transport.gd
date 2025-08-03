## @editing: Sora [br]
## @describe: 传送交互，进行交互后，开始传送
extends PassiveInteraction

@export var target_level: Level ## 所要传送的楼层
@export var target_point: Entity ## 所会传送到的目标地点

func _on_interact_activated(target_entity: Entity, _component: IComponent):
	target_entity.global_position = target_point.global_position
	target_entity.reparent(target_level)

func _on_interact_deactivated(_component: IComponent):
	pass
