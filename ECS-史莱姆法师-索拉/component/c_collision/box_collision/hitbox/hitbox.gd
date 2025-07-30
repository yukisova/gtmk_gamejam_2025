## @editing: Sora [br]
## @describe: 用于子弹或近战，与目标实体的HurtBox进行对接，对目标造成伤害
class_name Hitbox
extends BoxCollision

@export var equipment: StatusEquipment
@export var status: C_Status
var collision: CollisionShape2D

## FIXME 不知所谓的_ready代码写法，需要修正
func _ready() -> void:
	position = Vector2.ZERO
	var _collision = area_box.get_child(0) as CollisionShape2D
	_collision.disabled = true
	collision = _collision
