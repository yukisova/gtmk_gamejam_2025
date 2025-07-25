class_name Hitbox
extends BoxCollision

@export var equipment: StatusEquipment
@export var status: C_Status
var collision: CollisionShape2D

func _ready() -> void:
	position = Vector2(0,0)
	var _collision = area_box.get_child(0) as CollisionShape2D
	_collision.disabled = true
	collision = _collision
