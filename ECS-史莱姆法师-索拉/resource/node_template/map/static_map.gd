## 静态地图的管理
class_name StaticMap
extends Node

signal map_info_loaded

@export var player_spawn: PlayerSpawn
@export var levels: Node2D
@export var autoload_cutscene: Node
@export var cutscene_ref: Dictionary[String, Variant]

var level_count: int = 0
var level_loaded_count :int = 0

func _ready() -> void:
	for level in levels.get_children():
		if level is Level:
			level.level_fully_loaded.connect(_on_level_fully_loaded)
			level_count += 1
	
	for cutscene in autoload_cutscene.get_children():
		Main.s_signal_bus.game_data_loaded_compelete.connect(cutscene._start)

func _on_level_fully_loaded():
	level_loaded_count += 1
	if level_loaded_count == level_count:
		map_info_loaded.emit()
