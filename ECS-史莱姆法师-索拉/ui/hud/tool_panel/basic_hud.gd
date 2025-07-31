##@editing:	Sora
##@describe:	角色的基础hud
extends IHud

var binding_entity: Entity
@onready var health: ProgressBar = $Control/StatusPanel/VBoxContainer/Label/ProgressBar
@onready var magic: ProgressBar = $Control/StatusPanel/VBoxContainer/Label2/ProgressBar2
@onready var fitness: ProgressBar = $Control/StatusPanel/VBoxContainer/Label3/ProgressBar3

@export_group("时间循环", "time_")
@export var time_info: Label

var start_time: int
var real_time: int
var past_time: int:
	set(v):
		past_time = v % 1440
		time_info.text = time_to_str(past_time)

func _refresh():
	pass

func _initialize():
	#region 以下为时间系统的实现, 即使用Time单例类 
	start_time = Time.get_ticks_msec()
	past_time = 0
	real_time = 0
	#endregion


func _process(_delta: float) -> void:
	@warning_ignore("integer_division")
	var current_time = (Time.get_ticks_msec() - start_time) / 1000 % 1440
	if current_time != real_time:
		real_time = current_time
		if SGameState.state_machine._get_leaf_state() is GamingStateNormal:
			past_time += 1
		
		
func time_to_str(current_time: int):
	@warning_ignore("integer_division")
	var hour = str(current_time / 60).pad_zeros(2)
	var minute = str(current_time % 60).pad_zeros(2)
	return "%s: %s" % [hour, minute]
