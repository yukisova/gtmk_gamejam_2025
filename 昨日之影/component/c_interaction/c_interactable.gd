## SORA @editing: Sora [br]
## @describe: 交互组件，可以实现基于被动或主动的交互
@tool
class_name C_Interactable
extends IComponent

signal interact_activated ## 开始交互信号
signal interact_deactivated ## 取消交互信号


@export_flags("禁用自定义碰撞体", "禁用body检测") var interact_setting: int:
	set(v):
		interact_setting = v
		notify_property_list_changed()

@export var interact_object: CollisionObject2D :## 自定义交互碰撞体
	set(v):
		interact_object = v
		notify_property_list_changed()

@export var area_is_passive: bool ## 在交互碰撞体为Area2D的情况下确定交互碰撞体是主动触发还是被动触发
@export var interaction: PassiveInteraction ## 交互所关联的目标逻辑组件

func _enter_tree() -> void:
	component_name = ComponentName.c_interaction

## 初始化: 绑定交互的目标
func _initialize(_owner: Entity):
	super._initialize(_owner)
	
	interact_activated.connect(interaction._on_interact_activated.bind(self))
	interact_deactivated.connect(interaction._on_interact_deactivated.bind(self))
	
	register_inteactable_area()

func _validate_property(property: Dictionary) -> void:
	if interact_setting & 0b001 == 1:
		if property.name == "interact_object":
			property.usage = PROPERTY_USAGE_NO_EDITOR
			if component_body is not Area2D:
				if property.name == "area_is_passive":
					property.usage = PROPERTY_USAGE_NO_EDITOR

func register_inteactable_area():
	var final_body: CollisionObject2D
	if interact_setting & 0b001 == 0:
		final_body = interact_object
	else:
		final_body = component_body
	
	if final_body is Area2D: ## 保留用
		if interact_setting & 0b010 == 0: ## 未禁用body检测
			final_body.body_entered.connect(func(_body: Node2D):
				if _body.is_in_group("player"):
					if area_is_passive:
						interact_activated.emit()
					else:
						var entity = _body.owner as Entity
						if entity.list_base_components.has(IComponent.ComponentName.c_input_reactor):
							var c_input = entity.list_base_components[IComponent.ComponentName.c_input_reactor]
							c_input.interact_obj = self
			)
			final_body.body_exited.connect(func(_body: Node2D):
				if _body.is_in_group("player"):
					interact_deactivated.emit()
					if not area_is_passive:
						var entity = _body.owner as Entity
						if entity.list_base_components.has(IComponent.ComponentName.c_input_reactor):
							var c_input = entity.list_base_components[IComponent.ComponentName.c_input_reactor]
							c_input.interact_obj = null
			)
		final_body.area_entered.connect(func(_area: Area2D):
			if _area is SeekBox:
				_area.seek_target.append(self)
			)
		final_body.area_exited.connect(func(_area: Area2D):
				if _area is SeekBox:
					_area.seek_target.erase(self)
				)
