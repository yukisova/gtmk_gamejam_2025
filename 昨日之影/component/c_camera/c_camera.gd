## @editing: Sora [br]
## @describe: 聚焦于实体的Camera组件，包含Camera的跟随策略
@tool
class_name C_Camera
extends IComponent

@export_group("镜头控制策略","camera")
@export var camera_strategy: CameraFollowStrategy
@export var camera_source: Camera2D


func _enter_tree() -> void:
	component_name = ComponentName.c_camera

func _initialize(_owner: Entity):
	super(_owner)
	
	camera_strategy.c_camera = self
	
	## 根匹
	
	camera_source.limit_top = SLoadAndSave.gaming_data_cache.get("camera_top")
	camera_source.limit_bottom = SLoadAndSave.gaming_data_cache.get("camera_bottom")
	camera_source.limit_left = SLoadAndSave.gaming_data_cache.get("camera_left")
	camera_source.limit_right = SLoadAndSave.gaming_data_cache.get("camera_right")
	
func _update(_delta: float):
	camera_strategy._strategy(_delta)
