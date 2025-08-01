##@editing:	Sora
##@describe:	角色的基础hud
extends IHud

var binding_entity: Entity
@onready var health: ProgressBar = $Control/StatusPanel/VBoxContainer/Label/ProgressBar
@onready var magic: ProgressBar = $Control/StatusPanel/VBoxContainer/Label2/ProgressBar2
@onready var fitness: ProgressBar = $Control/StatusPanel/VBoxContainer/Label3/ProgressBar3

@export_group("时间循环", "time_")
@export var time_info: Label


func _initialize():
	var timeloop = SSubSystemManager.sub_systems[&"time_loop"] as SSTimeLoop
	timeloop.time_updated.connect(func(v: int):
		time_info.text = time_to_str(v)
		)
	time_info.text = time_to_str(timeloop.real_time)
	

func _refresh():
	pass

func time_to_str(current_time: int):
	@warning_ignore("integer_division")
	var hour = str(current_time / 60).pad_zeros(2)
	var minute = str(current_time % 60).pad_zeros(2)
	return "%s: %s" % [hour, minute]
