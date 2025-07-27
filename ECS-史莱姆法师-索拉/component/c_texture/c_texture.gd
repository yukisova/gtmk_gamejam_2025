##@editing:	Sora
##@describe:纹理组件,标明实体所使用的纹理
@tool
class_name C_Texture
extends IComponent

@export_subgroup("依赖")
@export var base_sprite: Sprite2D
@export var animation: AnimationPlayer

@export_subgroup("信息")


func _enter_tree() -> void:
	component_name = ComponentName.c_texture

func _initialize(_owner: Entity):
	super(_owner)
