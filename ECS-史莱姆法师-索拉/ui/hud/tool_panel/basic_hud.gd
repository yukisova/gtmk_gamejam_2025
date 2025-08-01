##@editing:	Sora
##@describe:	角色的基础hud
extends IHud

var binding_entity: Entity

@export_group("时间循环", "time_")
@export var hour_pointer: Line2D
@export var minute_pointer: Line2D

@export_group("背包抽屉", "bag_")
@export var bag_button: Button
@export var bag_slot: HBoxContainer

## 104,16 显示时
## -516,16 隐藏时


func _initialize():
	var timeloop = SSubSystemManager.sub_systems[&"time_loop"] as SSTimeLoop
	timeloop.time_updated.connect(func(v: int):
		rotate_pointer(v)
		)
	rotate_pointer(timeloop.real_time, false)
	
	bag_button.toggled.connect(func(v: bool):
		if v:
			drawer_on()
		else:
			drawer_off()
		)
	
	
	
func _refresh():
	pass

## FIXME 需要改成旋转时钟
func rotate_pointer(current_timer: int, need_tween: bool = true):

	var hour = current_timer / 60.0 / 24
	var minute = current_timer % 60 / 60.0
	
	var target_hour_rotation = hour * 2 * PI
	var target_min_rotation = minute * 2 * PI
	
	if need_tween:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(hour_pointer, "rotation", target_hour_rotation, 1.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
		tween.set_parallel(true)
		tween.tween_property(minute_pointer, "rotation", target_min_rotation, 1.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	

#region 抽屉式背包
func drawer_on():
	bag_button.button_mask ^= MOUSE_BUTTON_MASK_LEFT
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(bag_slot, "position", Vector2(0,16), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	bag_button.button_mask |= MOUSE_BUTTON_MASK_LEFT

func drawer_off():
	bag_button.button_mask ^= MOUSE_BUTTON_MASK_LEFT
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(bag_slot, "position", Vector2(-516,16), 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	bag_button.button_mask |= MOUSE_BUTTON_MASK_LEFT
#endregion
