extends Control

var is_dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS  # 确保接收输入事件[6](@ref)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and get_global_rect().has_point(event.global_position):
			# 点击时开始拖拽
			is_dragging = true
			drag_offset = global_position - event.global_position
			z_index = 100  # 置顶显示
			modulate.a = 0.7  # 半透明效果[3](@ref)

func _process(_delta):
	if is_dragging:
		global_position = get_global_mouse_position() + drag_offset
