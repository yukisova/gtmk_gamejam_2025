## 可拖拽物品
class_name DragableItem
extends TextureRect

var binding_item: Item:
	set(v):
		binding_item = v
		texture = binding_item.item_texture

var origin_position := global_position

var is_dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS  # 确保接收输入事件[6](@ref)
	z_index = 100

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and get_global_rect().has_point(event.global_position):
			# 点击时开始拖拽
			is_dragging = true
			drag_offset = global_position - event.global_position
			_tween_selected()
		else:
			_tween_unselected()
			is_dragging = false

func _process(_delta):
	if is_dragging:
		global_position = get_global_mouse_position() + drag_offset

func _tween_selected():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"scale", Vector2(0.7,0.7), 0.3)

func _tween_unselected():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"scale", Vector2(1,1), 0.3)
