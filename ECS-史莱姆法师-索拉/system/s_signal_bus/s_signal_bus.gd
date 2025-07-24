class_name S_SignalBus
extends ISystem

signal game_data_loaded_compelete ## 游戏的加载信息，用于触发所有的

func _enter_tree() -> void:
	Main.s_signal_bus = self
