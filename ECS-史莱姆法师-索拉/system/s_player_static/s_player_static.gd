class_name S_PlayerStatic
extends ISystem

signal player_located(target_level: Level, target_position: Vector2)
signal player_located_finished

@export var player_scene: PackedScene
@export_subgroup("依赖")
@export var input_listener: InputListener

static var player_static: Entity

func _enter_tree() -> void:
	Main.s_player_static = self

func _setup():
	player_located.connect(_on_player_located)

func _on_player_located(target_level: Level, target_position:Vector2):
	if (player_static != null):
		player_static.reparent(target_level)
		player_static.main_control.global_position = target_position
	else:
		player_static = player_scene.instantiate()
		player_static.main_control.global_position = target_position
		target_level.add_child(player_static)
	Main.s_ui_spawner.current_hud[&""].binding_entity = player_static
	Main.s_ui_spawner.current_hud[&""]._initialize()
	player_located_finished.emit()
