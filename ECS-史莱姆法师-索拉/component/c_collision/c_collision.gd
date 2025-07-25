## 各种额外碰撞体的集合
@tool
class_name C_Collision
extends IComponent

var collision: Dictionary[StringName, BoxCollision] = {}


func _enter_tree() -> void:
	component_name = ComponentName.c_collision

func _initialize(_owner: Entity):
	super._initialize(_owner)
	
	for box in get_children():
		collision[box.name] = box


	
