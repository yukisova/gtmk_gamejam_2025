@tool
## 移动组件, 让目标实现移动功能
class_name C_Move
extends IComponent

## 移动方向
var move_vector: Vector2:
	get:
		if component_body is CharacterBody2D:
			var input: C_Input = component_owner.list_base_components.get(ComponentName.c_input)
			if input == null:
				toward_direction = move_vector.normalized()
				return move_vector
			else:
				var input_vector = input.input_vector_dict.move
				toward_direction = input_vector.normalized()
				return input_vector
		else:
			push_error("目标不可被移动，请使用其他的方案")
			return Vector2.ZERO
	set(value):
		move_vector = value

## @e 移动速度
@export var move_speed: float

## 面对的方向
var toward_direction: Vector2

func _enter_tree() -> void:
	component_name = ComponentName.c_move

func _initialize(_owner: Entity):
	super._initialize(_owner)


## 移动逻辑的实现
func _update(delta: float):
	var body = component_body
	
	if body.is_in_group("player"):
		if (!move_vector.is_zero_approx()):
			body.velocity = body.velocity.lerp(move_vector * delta * 10 * move_speed, delta * 10)
		else:
			body.velocity = body.velocity.lerp(Vector2.ZERO, delta * 10)
		body.move_and_slide()
