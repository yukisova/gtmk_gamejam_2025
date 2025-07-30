## @editing: Sora [br]
## @describe: 静态地图类, s_map_data处理的主要对象
class_name StaticMap
extends Node

@export var player_spawn: PlayerSpawn ## 可选的玩家出生地
@export var levels: Node2D ## 层级集
@export var autoload_cutscene: Node ## 自动加载的过场事件
@export var cutscene_ref: Dictionary[String, Variant] ## 自动加载过场事件所能用到的参数

## 用于统计用的层级数
var level_count: int = 0
var level_loaded_count :int = 0
var level_initialized_count : int = 0

## _ready: 当游戏数据完全加载完毕后（发出game_data_loaded_compelete信号），如果存在过场剧情逻辑, 则立刻执行
func _ready() -> void:
	for level in levels.get_children():
		if level is Level:
			level.level_fully_loaded.connect(_on_level_fully_loaded)
			level.level_entity_fully_initialize.connect(_on_level_entity_fully_loaded)
			level_count += 1
	
	for cutscene in autoload_cutscene.get_children():
		SSignalBus.game_data_loaded_compelete.connect(cutscene._start.bind(cutscene_ref))

func _on_level_fully_loaded():
	level_loaded_count += 1
	if level_loaded_count == level_count:
		SSignalBus.map_info_loaded.emit.call_deferred()

func _on_level_entity_fully_loaded():
	level_initialized_count += 1
	if level_initialized_count == level_count:
		SSignalBus.game_data_loaded_compelete.emit.call_deferred()
