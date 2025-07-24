@tool
## 实体组件, 本身是一个平台
class_name Entity
extends Node2D

@export_subgroup("依赖")
@export var main_control: Node2D ## 主要控制对象
@export var component_container: Node2D
var body: CollisionObject2D:
	get:
		return get_child(0) 

var list_base_components: Dictionary[int, IComponent] = {} ## 基础组件组
var list_interface_components: Dictionary[int, IComponent] = {} ## 接口组件组, 批量更新非原生

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	if Main.entity_initialzable:
		_initialize()
	else:
		_initialize(true)

## FIXME 由TilemapLayer创建的实体后于
func _initialize(...args):
	for component in component_container.get_children():
		if (component is IComponent):
			if (component.component_type == 0):
				component._initialize(self)
				list_base_components[component.component_name] = component
			else:
				component._late_initialize(self)
				list_base_components[component.component_name] = component

	if !args.is_empty():
		Main.s_signal_bus.game_data_loaded_compelete.connect(_initialize)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	for base in list_base_components.values():
		base._update(delta)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	for base in list_base_components.values():
		base._fixed_update(delta)

## TODO 存档文件
func _info_to_dict() -> Dictionary:
	var data := {}
	return data
