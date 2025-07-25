@tool
class_name C_Texture
## 动画组件, 统一化显示目标的
extends IComponent

@export_subgroup("依赖")
@export var base_sprite: Sprite2D
@export var animation: AnimationPlayer

@export_subgroup("信息")


func _enter_tree() -> void:
	component_name = ComponentName.c_texture

func _initialize(_owner: Entity):
	super(_owner)
